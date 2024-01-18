"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fetchFunction = async (url) => {
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        const data = await response.json();
        return data;
    }
    catch (error) {
        console.error("Error loading the JSON file:", error);
    }
};
exports.default = fetchFunction;
//# sourceMappingURL=fetchFunction.js.map