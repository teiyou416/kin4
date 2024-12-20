import pulp
prob = pulp.LpProblem('Cost', pulp.LpMinimize)
m_1 = pulp.LpVariable('m_1', 0, 1000, 'Continuous') 
m_2 = pulp.LpVariable('m_2', 0, 1000, 'Continuous') 
m_3 = pulp.LpVariable('m_3', 0, 1000, 'Continuous') 
prob += 4 * m_1 + 1* m_2 + 1* m_3 
prob += 2 * m_1 + 1 * m_2 >= 3
prob += 3 * m_1 + 1 * m_3 >= 1 

prob.solve()

print(f"Material1: {pulp.value(m_1)}")
print(f"Material2: {pulp.value(m_2)}")
print(f"Material3: {pulp.value(m_3)}")
print(f"Minimum  : {4 * pulp.value(m_1) + 1 * pulp.value(m_2) + 1* pulp.value(m_3)}")
