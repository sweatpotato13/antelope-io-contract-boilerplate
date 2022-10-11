import { JsonRpc, Api } from "eosjs";
import { JsSignatureProvider } from "eosjs/dist/eosjs-jssig";
import fetch from 'cross-fetch';
import { TextDecoder, TextEncoder } from "text-encoding";
import { expect } from "chai";

describe("main contract test", () => {
    const rpc = new JsonRpc('http://localhost:8888', { fetch });
    const api = new Api({
        rpc,
        signatureProvider: new JsSignatureProvider([]),
        textDecoder: new TextDecoder(),
        textEncoder: new TextEncoder(),
    });

    describe("blockchain connection test", async () => {
        it("connect blockchain", async () => {
            const result = await rpc.get_info();
            expect(result.server_version_string).eq("v3.1.2");
        });
    });
});
