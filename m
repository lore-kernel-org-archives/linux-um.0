Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1ZEdzj-0007x6-Lu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 13:42:07 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEdzh-0004ns-Km
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 13:42:07 +0000
Received: from [217.255.217.12] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.80.1)
	(envelope-from <thomas@m3y3r.de>) id 1ZEdza-0005LM-V8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 15:41:59 +0200
Message-ID: <1436794918.3306.5.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 13 Jul 2015 15:41:58 +0200
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] uml_net zombie processes
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

SGksCgpUaGUgdW1sX25ldCBuZXR3b3JrIHNldHVwICJmYWlscyIgb24gbXkgY29tcHV0ZXIgd2l0
aDoKClsgICAxNS45MzAwMDBdIGhlbHBlcl93YWl0IDogd2FpdHBpZCBwcm9jZXNzIDExNjczIGZh
aWxlZCwgZXJybm8gPSAxMApbICAgMTUuOTMwMDAwXSAqIG1vZHByb2JlIHR1bgogICAgICAgICAg
ICAgICAqIGlmY29uZmlnIHRhcDAgMTkyLjE2OC4xMC4xIG5ldG1hc2sgMjU1LjI1NS4yNTUuMjU1
IHVwCiAgICAgICAgICAgICAgICogYmFzaCAtYyBlY2hvIDEgPiAvcHJvYy9zeXMvbmV0L2lwdjQv
aXBfZm9yd2FyZApbICAgMjAuNDgwMDAwXSBoZWxwZXJfd2FpdCA6IHdhaXRwaWQgcHJvY2VzcyAx
MTc4MCBmYWlsZWQsIGVycm5vID0gMTAKWyAgIDIwLjQ4MDAwMF0gKiByb3V0ZSBhZGQgLWhvc3Qg
MTkyLjE2OC4xMC4yIGRldiB0YXAwCiAgICAgICAgICAgICAgICogYmFzaCAtYyBlY2hvIDEgPgov
cHJvYy9zeXMvbmV0L2lwdjQvY29uZi90YXAwL3Byb3h5X2FycAoKYmVjYXVzZSBJIHJ1biB1bWwg
bGludXggYXMgYSBub3JtYWwgdXNlciBhbmQgSSBndWVzcyB0aGVzZSBjb21tYW5kcwpmYWlsLCBi
ZWNhdXNlIG9mIGluc3VmZmljaWVudCByaWdodHM6CmJhc2ggLWMgZWNobyAxID4gL3Byb2Mvc3lz
L25ldC9pcHY0L2lwX2ZvcndhcmQKYmFzaCAtYyBlY2hvIDEgPiAvcHJvYy9zeXMvbmV0L2lwdjQv
Y29uZi90YXAwL3Byb3h5X2FycAoKQnV0IHRoaXMgZmFpbHVyZSBpcyBva2F5IGZvciBtZSwgYXMg
ZmlyZXdhbGxkLCBzZXRzIGFib3ZlIG9wdGlvbnMKY29ycmVjdGx5IG9uIG15IGhvc3QgY29tcHV0
ZXIuCgpUaGUgcHJvYmxlbSBJIHNlZSBpcyB0aGF0IFVNTCBsaXN0IHR3byB6b21iaWUgcHJvY2Vz
c2VzOgogIDExNzgwIHJvb3QgICAgICAgMjAgICAwICAgICAwICAgICAwICAgICAwIFogIDAuMCAg
MC4wICAwOjAwLjAwIDE1OjM0IOKUgiAg4pSCICAgICDilJzilIAgdW1sX25ldAogIDExNjczIHJv
b3QgICAgICAgMjAgICAwICAgICAwICAgICAwICAgICAwIFogIDAuMCAgMC4wICAwOjAwLjAwIDE1
OjM0IOKUgiAg4pSCICAgICDilJzilIAgdW1sX25ldAoKVU1MIHNlZW1zIHRvIG5ldmVyIHJlYXAg
dGhvc2UgdHdvIHByb2Nlc3NlcywgbGlrZWx5IGJlY2F1c2Ugb2YgZXJybm89MTAgZXhpdCBjb2Rl
LgoKYW55IGlkZWEgaG93IHRvIGZpeCB0aGlzPwoKd2l0aCBraW5kIHJlZ2FyZHMKdGhvbWFzCgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRvbid0IExpbWl0IFlvdXIgQnVzaW5lc3MuIFJlYWNoIGZv
ciB0aGUgQ2xvdWQuCkdpZ2VORVQncyBDbG91ZCBTb2x1dGlvbnMgcHJvdmlkZSB5b3Ugd2l0aCB0
aGUgdG9vbHMgYW5kIHN1cHBvcnQgdGhhdAp5b3UgbmVlZCB0byBvZmZsb2FkIHlvdXIgSVQgbmVl
ZHMgYW5kIGZvY3VzIG9uIGdyb3dpbmcgeW91ciBidXNpbmVzcy4KQ29uZmlndXJlZCBGb3IgQWxs
IEJ1c2luZXNzZXMuIFN0YXJ0IFlvdXIgQ2xvdWQgVG9kYXkuCmh0dHBzOi8vd3d3LmdpZ2VuZXRj
bG91ZC5jb20vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

