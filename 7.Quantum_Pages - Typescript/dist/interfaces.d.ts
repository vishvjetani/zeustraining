export interface Course {
    image: string;
    name: string;
    isFavorite: boolean;
    subject: string;
    grade: {
        mainGrade: number;
        additionalGrade: number;
    };
    syllabus: {
        units: number;
        lessons: number;
        topics: number;
    };
    class: {
        all: string[];
        selected: string | string[];
    };
    expired: boolean;
    noofstudents?: number;
    date?: string[];
    icons: string[];
}
export interface Alert {
    title: string;
    date: string;
    time: string;
    unread: boolean;
    course?: string;
    class?: string;
}
export interface Announcement {
    PA: string;
    message: string;
    files?: number;
    date: string;
    time: string;
    unread: boolean;
    course?: string;
}
