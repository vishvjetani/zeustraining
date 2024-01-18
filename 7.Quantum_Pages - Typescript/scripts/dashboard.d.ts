interface Course {
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
interface Alert {
    title: string;
    date: string;
    time: string;
    unread: boolean;
    course?: string;
    class?: string;
}
interface Announcement {
    PA: string;
    message: string;
    files?: number;
    date: string;
    time: string;
    unread: boolean;
    course?: string;
}
declare const fetchFunction: (url: string) => Promise<any>;
declare const toggleAlertandAnnouncement: (event: Event) => void;
declare const renderQuantumDashboard: (courses: Course[]) => void;
declare const renderAlerts: (alerts: Alert[]) => void;
declare const renderAnnouncements: (announcements: Announcement[]) => void;
