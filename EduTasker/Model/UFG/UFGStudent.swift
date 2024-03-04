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
        var lab1: Double?
        var lab2: Double?
        var lab3: Double?
        var lab4: Double?
        var exa1: Double?
        var exa2: Double?
        var exa3: Double?
        var exa4: Double?
        
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
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.subjectId = try container.decode(String.self, forKey: .subjectId)
            self.subjectName = try container.decode(String.self, forKey: .subjectName)
            self.subjectGroup = try container.decode(String.self, forKey: .subjectGroup)
            self.subjectShedule = try container.decode(String.self, forKey: .subjectShedule)
            self.subjectClassroom = try container.decode(String.self, forKey: .subjectClassroom)
            self.subjectProfessor = try container.decode(String.self, forKey: .subjectProfessor)
            self.finalGrade = try container.decode(Double.self, forKey: .finalGrade)
            
            do {
                self.lab1 = try Double(container.decode(Int.self, forKey: .lab1))
                self.lab2 = try Double(container.decode(Int.self, forKey: .lab2))
                self.lab3 = try Double(container.decode(Int.self, forKey: .lab3))
                self.lab4 = try Double(container.decode(Int.self, forKey: .lab4))
                self.exa1 = try  Double(container.decode(Int.self, forKey: .exa1))
                self.exa2 = try  Double(container.decode(Int.self, forKey: .exa2))
                self.exa3 = try  Double(container.decode(Int.self, forKey: .exa3))
                self.exa4 = try  Double(container.decode(Int.self, forKey: .exa4))
            } catch {
                self.lab1 = try container.decode(Double.self, forKey: .lab1)
                self.lab2 = try container.decode(Double.self, forKey: .lab2)
                self.lab3 = try container.decode(Double.self, forKey: .lab3)
                self.lab4 = try container.decode(Double.self, forKey: .lab4)
                
                self.exa1 = try container.decode(Double.self, forKey: .exa1)
                self.exa2 = try container.decode(Double.self, forKey: .exa2)
                self.exa3 = try container.decode(Double.self, forKey: .exa3)
                self.exa4 = try container.decode(Double.self, forKey: .exa4)
            }
        }
        
    }
    

}


