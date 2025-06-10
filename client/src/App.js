import React, { useState } from 'react';

function App() {
  const [input, setInput] = useState('');
  const [result, setResult] = useState('');

  const handleCalculate = async () => {
    try {
      const response = await fetch("http://localhost:4567/add", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ input })
      });
      const data = await response.json();
      if (response.ok) {
        setResult(`Result: ${data.result}`);
      } else {
        setResult(`Error: ${data.error}`);
      }
    } catch (err) {
      setResult("Error calling Ruby server");
    }
  };

  return (
    <div style={{ padding: '2rem' }}>
      <h2>String Calculator (Ruby-powered)</h2>
      <input
        type="text"
        value={input}
        onChange={e => setInput(e.target.value)}
        style={{ width: '300px', padding: '0.5rem' }}
      />
      <button onClick={handleCalculate} style={{ marginLeft: '1rem' }}>Calculate</button>
      <p>{result}</p>
    </div>
  );
}

export default App;
