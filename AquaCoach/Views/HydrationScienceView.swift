import SwiftUI

struct HydrationScienceView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.white, Color.cyan.opacity(0.08)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    HStack {
                        Spacer()

                        Button {
                            dismiss()
                        } label: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 46, height: 46)
                                .overlay(
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                )
                                .shadow(radius: 2)
                        }
                    }

                    scienceSection(
                        icon: "drop.fill",
                        iconColor: .cyan,
                        title: "Hydration in different beverages",
                        body: """
Hydration varies from one type of liquid to another. That’s why some beverages have different hydration ratios based on the scientific studies found in this field.

For example:

Tea has a 90% hydration ratio. If you add 10oz (300ml), it will increase your hydration only by 9oz (270ml).

Milk has a 130% hydration ratio because it contains a little fat, sugar lactose, some protein, and sodium. All of that combined helps milk hydrate your body better than water. The sodium in milk acts like a sponge and holds onto the water in the body, which results in producing less urine. That’s why sometimes people can feel swelling after they drink a lot of milk. If you add 10oz (300ml) it will increase your hydration by 13oz (390ml).

As for the fruits and vegetables, many contain 80–95% water. But it’s nearly impossible to eat such a large volume required to replace a single glass of water. Fruits are a tasty and nutritious addition to your diet, but they’re more of a snack than a hydration solution. To stay fully hydrated, pair your fruit servings with plenty of water!
"""
                    )

                    scienceSection(
                        icon: "wineglass.fill",
                        iconColor: .purple,
                        title: "How alcohol affects your hydration",
                        body: """
To put it simply, when you drink alcohol, your body doesn’t keep water that efficiently, and you pee more.

In other words, alcohol is a diuretic. It causes your body to remove fluids from your blood through the renal system at a much quicker rate than other liquids. Alcohol also reduces how much vasopressin your body makes. Vasopressin is an antidiuretic hormone. It causes the body to hold onto water, which typically limits how much urine your kidneys make. The action of suppressing this hormone exacerbates the diuretic effect and leads to dehydration. That’s why alcohol drinks have negative hydration ratios.

For example: Wine has a negative -95% hydration ratio. If you add 10oz (300ml), it will decrease your hydration by 9.5oz (285ml).

According to the common system, alcohol consumption is measured by counting how many standard drinks you have.

For example: 1 standard drink is equal to Beer 12oz (355ml) or Wine 4oz (125ml) or Strong Liquor 1.5oz (50ml), because all have similar alcohol content.
"""
                    )

                    scienceSection(
                        icon: "cup.and.saucer.fill",
                        iconColor: .brown,
                        title: "Caffeine",
                        body: """
For beverages that contain caffeine, it’s calculated in mg per 8oz (250ml).

For example: Black Tea – 47mg caffeine, which means it has 47mg in every 8oz (250ml) you drink.
"""
                    )

                    scienceSection(
                        icon: "flame.fill",
                        iconColor: .orange,
                        title: "Calories",
                        body: """
For beverages that contain calories, it’s calculated in cal per 8oz (250ml).

For example: Soda – 100 cal, which means it has 100 calories in every 8oz (250ml) you drink.
"""
                    )

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Go deeper into the science of hydration")
                            .font(.title3.bold())

                        Group {
                            Text("• ncbi.nlm.nih.gov/pmc/articles/pmc2908954/")
                            Text("• ncbi.nlm.nih.gov/pmc/articles/pmc4207053/")
                            Text("• ncbi.nlm.nih.gov/pmc/articles/pmc5646208/")
                            Text("• drinkhydrant.com/blogs/news/does-alcohol-dehydrate-you")
                            Text("• ncbi.nlm.nih.gov/pmc/articles/pmc4473081/")
                            Text("• mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/in-depth/water/art-20044256")
                            Text("• healthline.com/health/does-alcohol-dehydrate-you")
                            Text("• rethinkingdrinking.niaaa.nih.gov/how-much-too-much/whats-standard-drink")
                        }
                        .font(.footnote)
                        .foregroundColor(.teal)
                    }
                    .padding()
                    .background(Color.white.opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding()
            }
        }
    }

    @ViewBuilder
    func scienceSection(icon: String, iconColor: Color, title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(iconColor)
                    )

                Text(title)
                    .font(.system(size: 22, weight: .bold))
            }

            Text(body)
                .font(.body)
                .foregroundColor(.gray)
                .lineSpacing(5)
        }
        .padding()
        .background(Color.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
