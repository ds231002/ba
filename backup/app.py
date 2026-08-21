import streamlit as st

st.set_page_config(
    page_title="LLM-Orchestrierung",
    layout="wide"
)

st.title("LLM-Orchestrierung")

st.subheader("Subheader")

orchestration_methods = [
    "deterministisch (Baseline)",
    "plan-basiert",
    "iterativ (ReAct)"
]

st.selectbox(
    "Orchestrierungsmethode",
    options=orchestration_methods,
    key="orchestration_method"
)