# ── Owners ──────────────────────────────────────────────
ana = Owner.create!(
  first_name: "Ana",
  last_name:  "Martínez",
  email:      "ana.martinez@email.com",
  phone:      "+56912345678",
  address:    "Av. Providencia 1234, Santiago"
)

carlos = Owner.create!(
  first_name: "Carlos",
  last_name:  "Rojas",
  email:      "carlos.rojas@email.com",
  phone:      "+56987654321",
  address:    "Los Leones 567, Vitacura"
)

lucia = Owner.create!(
  first_name: "Lucía",
  last_name:  "Fernández",
  email:      "lucia.fernandez@email.com",
  phone:      "+56955544433",
  address:    "Calle Nueva 89, Ñuñoa"
)

# ── Vets ────────────────────────────────────────────────
dr_silva = Vet.create!(
  first_name:     "Diego",
  last_name:      "Silva",
  email:          "d.silva@vetclinic.cl",
  phone:          "+56922233344",
  specialization: "Medicina General"
)

dra_lopez = Vet.create!(
  first_name:     "Valentina",
  last_name:      "López",
  email:          "v.lopez@vetclinic.cl",
  phone:          "+56933344455",
  specialization: "Cirugía"
)

# ── Pets ─────────────────────────────────────────────────
firulais = ana.pets.create!(
  name:          "Firulais",
  species:       "dog",
  breed:         "Labrador",
  date_of_birth: "2019-03-15",
  weight:        28.5
)

michi = ana.pets.create!(
  name:          "Michi",
  species:       "cat",
  breed:         "Siamés",
  date_of_birth: "2021-07-20",
  weight:        4.2
)

rex = carlos.pets.create!(
  name:          "Rex",
  species:       "dog",
  breed:         "Pastor Alemán",
  date_of_birth: "2018-11-05",
  weight:        35.0
)

bunny = carlos.pets.create!(
  name:          "Bunny",
  species:       "rabbit",
  breed:         "Holland Lop",
  date_of_birth: "2022-01-10",
  weight:        2.1
)

luna = lucia.pets.create!(
  name:          "Luna",
  species:       "cat",
  breed:         "Persa",
  date_of_birth: "2020-05-30",
  weight:        3.8
)

# ── Appointments ─────────────────────────────────────────
a1 = Appointment.create!(
  pet: firulais, vet: dr_silva,
  date:   "2024-11-10 10:00:00",
  reason: "Control anual y vacunas",
  status: :completed
)

a2 = Appointment.create!(
  pet: michi, vet: dra_lopez,
  date:   "2024-12-05 11:30:00",
  reason: "Castración",
  status: :completed
)

a3 = Appointment.create!(
  pet: rex, vet: dr_silva,
  date:   "2025-01-15 09:00:00",
  reason: "Revisión de cadera",
  status: :in_progress
)

a4 = Appointment.create!(
  pet: bunny, vet: dra_lopez,
  date:   "2026-06-20 14:00:00",
  reason: "Revisión general",
  status: :scheduled
)

a5 = Appointment.create!(
  pet: luna, vet: dr_silva,
  date:   "2024-10-01 16:00:00",
  reason: "Dermatitis",
  status: :cancelled
)

# ── Treatments ───────────────────────────────────────────
a1.treatments.create!(
  name:            "Vacuna antirrábica",
  medication:      "Rabisin",
  dosage:          "1 ml IM",
  notes:           "Sin reacciones adversas. Próxima dosis en 12 meses.",
  administered_at: "2024-11-10 10:30:00"
)

a1.treatments.create!(
  name:            "Desparasitación",
  medication:      "Drontal Plus",
  dosage:          "1 comprimido",
  notes:           "Administrado sin inconvenientes.",
  administered_at: "2024-11-10 10:45:00"
)

a2.treatments.create!(
  name:            "Castración",
  medication:      "Propofol + Isoflurano",
  dosage:          "Según peso corporal",
  notes:           "Cirugía sin complicaciones. Recuperación normal.",
  administered_at: "2024-12-05 12:00:00"
)

a3.treatments.create!(
  name:            "Antiinflamatorio",
  medication:      "Meloxicam",
  dosage:          "0.1 mg/kg",
  notes:           "Dolor moderado en cadera derecha. Seguimiento en 2 semanas.",
  administered_at: "2025-01-15 09:30:00"
)

a3.treatments.create!(
  name:            "Radiografía",
  medication:      "N/A",
  dosage:          "N/A",
  notes:           "Displasia leve de cadera. Se recomienda dieta baja en calorías.",
  administered_at: "2025-01-15 09:15:00"
)

puts "✅ Seed completado: #{Owner.count} owners, #{Pet.count} pets, #{Vet.count} vets, #{Appointment.count} appointments, #{Treatment.count} treatments"