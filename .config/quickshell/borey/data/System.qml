import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    // Memory
    property int memoryUsed: 0
    property int memoryTotal: 0
    property int memoryUsedPercent: 0
    // Cpu
    property int cpuUsedPercent: 0
    property var cpuCoreUsedPercent: []
    property var _prevCpuIdle: 0
    property var _prevCpuTotal: 0
    property var _prevCoreIdle: []
    property var _prevCoreTotal: []
    // Battery
    property int batteryPercent: -1          // -1 means no battery or read error
    property string batteryStatus: "Unknown" // "Charging", "Discharging", "Full", "Unknown"

    function parseMemoryInfo(data) {
        const memTotalMatch = data.match(/MemTotal:\s+(\d+)/);
        const memAvailMatch = data.match(/MemAvailable:\s+(\d+)/);
        const memoryTotal = memTotalMatch ? parseInt(memTotalMatch[1], 10) : 0;
        const memoryAvailable = memAvailMatch ? parseInt(memAvailMatch[1], 10) : 0;
        const memoryUsed = memoryTotal - memoryAvailable;
        const memoryUsedPercent = (memoryUsed / memoryTotal) * 100;
        root.memoryTotal = memoryTotal;
        root.memoryUsed = memoryUsed;
        root.memoryUsedPercent = memoryUsedPercent;
    }

    function parseCpuInfo(data) {
        // total cpu
        const cpuMatch = data.match(/^cpu\s+([\d\s]+)$/m);
        if (cpuMatch) {
            const parts = cpuMatch[1].trim().split(/\s+/).map(Number);
            const user = parts[0] || 0;
            const nice = parts[1] || 0;
            const system = parts[2] || 0;
            const idle = parts[3] || 0;
            const iowait = parts[4] || 0;
            const irq = parts[5] || 0;
            const softirq = parts[6] || 0;
            const steal = parts[7] || 0;
            const guest = parts[8] || 0;
            const guestNice = parts[9] || 0;
            const total = user + nice + system + idle + iowait + irq + softirq + steal + guest + guestNice;
            if (root._prevCpuTotal > 0) {
                const deltaIdle = idle - root._prevCpuIdle;
                const deltaTotal = total - root._prevCpuTotal;
                if (deltaTotal > 0)
                    root.cpuUsedPercent = Math.round(100 * (1 - deltaIdle / deltaTotal));

            }
            root._prevCpuIdle = idle;
            root._prevCpuTotal = total;
        }
        // cores
        const coreMatches = data.match(/^cpu(\d+)\s+([\d\s]+)$/gm);
        if (coreMatches) {
            const coreCount = coreMatches.length;
            const newCorePercent = new Array(coreCount).fill(0);
            // Инициализация prev массивов, если изменилось количество ядер
            if (coreCount !== root._prevCoreIdle.length) {
                root._prevCoreIdle = new Array(coreCount).fill(0);
                root._prevCoreTotal = new Array(coreCount).fill(0);
            }
            for (let i = 0; i < coreCount; i++) {
                const parts = coreMatches[i].match(/^cpu\d+\s+([\d\s]+)$/);
                if (!parts)
                    continue;

                const nums = parts[1].trim().split(/\s+/).map(Number);
                const user = nums[0] || 0;
                const nice = nums[1] || 0;
                const system = nums[2] || 0;
                const idle = nums[3] || 0;
                const iowait = nums[4] || 0;
                const irq = nums[5] || 0;
                const softirq = nums[6] || 0;
                const steal = nums[7] || 0;
                const guest = nums[8] || 0;
                const guestNice = nums[9] || 0;
                const total = user + nice + system + idle + iowait + irq + softirq + steal + guest + guestNice;
                if (root._prevCoreTotal[i] > 0) {
                    const deltaIdle = idle - root._prevCoreIdle[i];
                    const deltaTotal = total - root._prevCoreTotal[i];
                    if (deltaTotal > 0)
                        newCorePercent[i] = Math.round(100 * (1 - deltaIdle / deltaTotal));

                }
                root._prevCoreIdle[i] = idle;
                root._prevCoreTotal[i] = total;
            }
            // generate signal
            root.cpuCoreUsedPercent = newCorePercent;
        }
    }

    function parseBatteryInfo() {
        const capText = batteryCapacity.text().trim();
        if (capText !== "") {
            const cap = parseInt(capText, 10);
            root.batteryPercent = isNaN(cap) ? -1 : cap;
        } else {
            root.batteryPercent = -1;
        }

        const statText = batteryStatusFile.text().trim();
        root.batteryStatus = (statText !== "") ? statText : "Unknown";
    }

    FileView {
        id: memoryInfo
        path: "/proc/meminfo"
    }

    FileView {
        id: cpuInfo
        path: "/proc/stat"
    }

    // Battery files (assumes standard Linux power supply interface)
    FileView {
        id: batteryCapacity
        path: "/sys/class/power_supply/BAT1/capacity"
    }

    FileView {
        id: batteryStatusFile
        path: "/sys/class/power_supply/BAT1/status"
    }

    Timer {
        id: updateTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            memoryInfo.reload();
            parseMemoryInfo(memoryInfo.text());

            cpuInfo.reload();
            parseCpuInfo(cpuInfo.text());

            batteryCapacity.reload();
            batteryStatusFile.reload();
            parseBatteryInfo();
        }
    }
}
