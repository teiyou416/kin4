import pulp

prob = pulp.LpProblem('Cost', pulp.LpMaximize)
m_1 = pulp.LpVariable('m_1', 0, 1000, 'Continuous') 
m_2 = pulp.LpVariable('m_2', 0, 1000, 'Continuous') 
m_3 = pulp.LpVariable('m_3', 0, 1000, 'Continuous') 
prob += 50 * m_1 + 60 * m_2 + 80 * m_3
prob += 6 * m_1 + 8 * m_2 + 13 * m_3 <= 284 
prob +=  5 * m_1 + 3 * m_2 + 5 * m_3 <= 120 

prob.solve()

print(f"Material1: {pulp.value(m_1)}")
print(f"Material2: {pulp.value(m_2)}")
print(f"Material3: {pulp.value(m_3)}")
print(f"Minimum  : {50 * pulp.value(m_1) + 60 * pulp.value(m_2) + 80 * pulp.value(m_3)}")
