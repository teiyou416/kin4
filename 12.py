import pulp
prob = pulp.LpProblem('Cost', pulp.LpMinimize)
m_1 = pulp.LpVariable('m_1', 0, 1000, 'Continuous') 
m_2 = pulp.LpVariable('m_2', 0, 1000, 'Continuous') 
prob += 284 * m_1 +120 * m_2 
prob += 6 * m_1 + 5 * m_2 >= 50
prob += 8 * m_1 + 3 * m_2 >= 60
prob += 13 * m_1 + 5 * m_2 >= 80 

prob.solve()

print(f"Material1: {pulp.value(m_1)}")
print(f"Material2: {pulp.value(m_2)}")
print(f"Minimum  : {284 * pulp.value(m_1) + 120 * pulp.value(m_2) }")
