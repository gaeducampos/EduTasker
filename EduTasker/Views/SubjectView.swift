//
//  SubjectView.swift
//  EduTasker
//
//  Created by Gabriel Campos on 8/1/24.
//

import SwiftUI

struct SubjectView: View {
    let subject: UFGStudent.UFGStudentGrade
    let action: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(.red)
                    .frame(height: 50)
                    .overlay {
                        Image(systemName: "x.circle")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 51, height: 51)
                            
                    }
                    .onTapGesture {
                        action()
                    }
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(Assests.Color.appThemeColor.rawValue))
                    .frame(height: 50)
                    .overlay {
                        Text("\(subject.subjectName) 📚")
                            .font(.custom("Arial", size: 15))
                            .padding(.horizontal, 30)
                            .padding(.top)
                            .minimumScaleFactor(0.1)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .offset(y: -5)
                    }
                    
            }
            .padding(.horizontal)
            
            
            ProfileCard(name: subject.subjectProfessor,
                        username: subject.subjectId,
                        icon: Assests.Image.teacher.rawValue
            )
            .padding(.horizontal)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 8)
                .padding(.horizontal)
                .overlay {
                    VStack {
                        
                        Text(subject.subjectShedule.replacingOccurrences(of: ", ", with: "\n"))
                            .padding(.top)
                        
                        Text("AULA: \(subject.subjectClassroom)")
                            .padding(.top)
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                GradeCell(labGrade: subject.lab1.rawValue, examGrade: subject.exa1.rawValue, title: "Primer Periodo")
                                GradeCell(labGrade: subject.lab2.rawValue, examGrade: subject.exa2.rawValue, title: "Segundo Periodo")
                                GradeCell(labGrade: subject.lab3.rawValue, examGrade: subject.exa3.rawValue, title: "Tercer Periodo")
                                GradeCell(labGrade: subject.lab4.rawValue, examGrade: subject.exa4.rawValue, title: "Cuarto Periodo")
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
        }
    }
}

private struct GradeCell: View {
    let labGrade: Double
    let examGrade: Double
    let title: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Arial", size: 17))
                .fontWeight(.semibold)
            
            HStack {
                Text("Laboratorio")
                
                Spacer()
                
                Text(labGrade.formattedStringWithOneDecimalPlaces())
                    .padding(.trailing, 25)
            }
            
            HStack {
                Text("Examen")
                
                Spacer()
                
                Text(examGrade.formattedStringWithOneDecimalPlaces())
                    .padding(.trailing, 25)
            }
        }
        .padding(.leading, 25)
    }
}

