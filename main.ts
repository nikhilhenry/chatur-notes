import { Configuration, OpenAIApi } from "npm:openai@3";
import "https://deno.land/std@0.178.0/dotenv/load.ts";
import { serve } from "https://deno.land/std@0.175.0/http/server.ts";

const apiKey = Deno.env.get("API_KEY");

console.log(`API key is ${apiKey}`);

const getCompletion = async (prompt: string, token: number) => {
    const configuration = new Configuration({
        apiKey: apiKey,
    });
    const openai = new OpenAIApi(configuration);
    const response = await openai.createCompletion({
        model: "text-davinci-003",
        prompt: prompt,
        temperature: 0.8,
        max_tokens: token,
    });
    return response.data.choices;
};

async function handler(req: Request): Promise<Response> {
    const data = await req.json();
    console.log(data);
    const prompt = "give me notes on the following material " + data.content;

    const response = await getCompletion(prompt, 100);

    return new Response(response[0].text);
}

console.log("Listening on http://localhost:8000");
serve(handler);
