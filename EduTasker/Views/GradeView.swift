import SwiftUI

struct GradeView: View {
    @StateObject var viewModel: GradeViewModel
    var body: some View {
        VStack {
            ProfileCard(
                name: viewModel.studentInfo?.name ?? "",
                username: viewModel.studentInfo?.username ?? "",
                icon: Assests.Image.studentIcon.rawValue
            )
            .padding(.horizontal)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .frame(height: 70)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 8)
                .padding(.horizontal)
                .overlay {
                    HStack {
                        Text("CUM ACTUAL")
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(Assests.Color.appThemeColor.rawValue))
                            .frame(width: 100, height: 40)
                            .overlay {
                                Text("\(viewModel.studentCum?.value.formattedStringWithOneDecimalPlaces() ?? "")")
                            }
                    }
                    .padding(.horizontal, 25)
                }
            
            Text("ACTUALMENTE CURSANDO:")
                .font(.custom("Arial", size: 20))
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()], content: {
                    ForEach(viewModel.studentSemesterInfo?.studentInfo.grades ?? [], id: \.subjectId) { subject in
                        SubjectCard(subject: subject)
                            .onTapGesture {
                                viewModel.presentSubjectDetail.send(subject)
                            }
                    }
                })
                .padding(.top)
            }
            .refreshable {
                if let isExpired = NetworkProvider.student?.jwt?.expired, !isExpired {
                    viewModel.getStudentCum()
                    viewModel.getStudentGrades()
                } else {
                    viewModel.presentTokenAlertSubject.send()
                }
            }
            
        }
    }
}

private struct SubjectCard: View {
    let subject: UFGStudent.UFGStudentGrade
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.white)
            .frame(width: 150, height: 200)
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 8)
            .overlay {
                VStack {
                    Circle()
                        .fill(Color(Assests.Color.appThemeColor.rawValue))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text("\(subject.finalGrade.formattedStringWithOneDecimalPlaces())")
                                .font(.custom("Arial", size: 13))
                        }
                    
                    Spacer()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topTrailing)
                .padding(.trailing, 3)
                .padding(.top, 4)
                
                VStack {
                    Image(Assests.Image.subjectIcon.rawValue)
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    Text("\(subject.subjectName)")
                        .font(.custom("Arial", size: 12))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
            }
    }
}

struct ProfileCard: View {
    let name: String
    let username: String
    let icon: String
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(height: 150)
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 8)
            .overlay {
                HStack {
                    Circle()
                        .fill(Color(Assests.Color.appThemeColor.rawValue))
                        .frame(width: 120, height: 120)
                        .overlay {
                            Image(icon)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .clipShape(.circle)
                            
                        }
                    
                    VStack(spacing: 20) {
                        Text(name)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                        
                        Text(username)
                            
                    }
                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
    }
}

#Preview {
    GradeView(viewModel: .init(service: .init(networkProvider: .init())))
}
