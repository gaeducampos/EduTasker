import Foundation

struct UFGStudent: Decodable {
    let studentInfo: UFGStudentInfo
    
    enum CodingKeys: String, CodingKey {
        case studentInfo = "estudiante"
    }
    
    struct UFGStudentInfo: Decodable {
        let studentId: String
        let studentName: String
        let studentBachelorName: String
        let grades: [UFGStudentGrade]
        
        enum CodingKeys: String, CodingKey {
            case studentId = "carnet"
            case studentName = "nombreEstudiante"
            case studentBachelorName = "nombre"
            case grades = "notas"
        }
    }

    struct UFGStudentGrade: Decodable {
        let subjectId: String
        let subjectName: String
        let subjectGroup: String
        let subjectShedule: String
        let subjectClassroom: String
        let subjectProfessor: String
        let finalGrade: Double
        let lab1: LabGrade
        let lab2: LabGrade
        let lab3: LabGrade
        let lab4: LabGrade
        let exa1: ExamGrade
        let exa2: ExamGrade
        let exa3: ExamGrade
        let exa4: ExamGrade
        
        enum LabGrade: Double, Decodable {
            case lab1, lab2, lab3, lab4
        }
        
        enum ExamGrade: Double, Decodable {
            case exa1, exa2, exa3, exa4
        }
        
        enum CodingKeys: String, CodingKey {
            case subjectId = "idmateria"
            case subjectName = "materia"
            case subjectGroup = "grupot"
            case subjectShedule = "horario"
            case subjectClassroom = "aula"
            case subjectProfessor = "docente"
            case finalGrade = "notaf"
            case lab1, lab2, lab3, lab4
            case exa1, exa2, exa3, exa4
        }
        
        struct UFGPeriodGrade: Decodable, Identifiable {
            var id = UUID()
            let labGrade: LabGrade
            let examGrade: ExamGrade
            
            var title: String {
                switch labGrade {
                case .lab1:
                    return "Primer Periodo"
                case .lab2:
                    return "Segundo Periodo"
                case .lab3:
                    return "Tercer Periodo"
                case .lab4:
                    return "Cuarto Periodo"
                }
            }
        }
        
    }
    

}


