pragma Singleton
import Quickshell

Singleton {
    function convertRounded(input: real, from: string, to: string, decimals: int): real {
        function conversionFactor(unit: string): int {
            if (unit === "B") return 1;
            if (unit === "KB") return 1000;
            if (unit === "KiB" || unit === "K") return 1024;
            if (unit === "MB") return 1000000;
            if (unit === "MiB" || unit === "M") return 1048576;
            if (unit === "GB") return 1000000000;
            if (unit === "GiB" || unit === "G") return 1073741824;
            return 0;
        }
        
        return (input * conversionFactor(from) / conversionFactor(to)).toFixed(decimals);
    }

    function capitalize(str: string): string {
        return String(str).charAt(0).toUpperCase() + String(str).slice(1);
    }
}
