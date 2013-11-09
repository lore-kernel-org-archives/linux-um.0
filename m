Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VfEI8-0000Ox-KO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 19:33:56 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VfEI6-0001bb-Ur
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 19:33:56 +0000
Message-ID: <527E8E19.9030802@nod.at>
Date: Sat, 09 Nov 2013 20:33:45 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <526696BF.6050909@gmx.de>	<CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com>	<5266A698.10400@gmx.de>	<5266B60A.1000005@nod.at>	<52715AD1.7000703@gmx.de>
	<CALYGNiPvJF1u8gXNcX1AZR5-VkGqJnaose84KBbdaoBAq8aoGQ@mail.gmail.com>
	<527AB23D.2060305@gmx.de> <527AB51B.1020005@nod.at>
	<527E87EA.8080700@gmx.de>
In-Reply-To: <527E87EA.8080700@gmx.de>
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
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Konstantin Khlebnikov <koct9i@gmail.com>

QW0gMDkuMTEuMjAxMyAyMDowNywgc2NocmllYiBUb3JhbGYgRsO2cnN0ZXI6Cj4gT24gMTEvMDYv
MjAxMyAxMDozMSBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiBBbSAwNi4xMS4yMDEz
IDIyOjE4LCBzY2hyaWViIFRvcmFsZiBGw7Zyc3RlcjoKPj4+IE9uIDExLzA2LzIwMTMgMDU6MDYg
UE0sIEtvbnN0YW50aW4gS2hsZWJuaWtvdiB3cm90ZToKPj4+PiBJbiB0aGlzIGNhc2UgaXQgbXVz
dCBzdG9wIGFmdGVyIHNjYW5uaW5nIHdob2xlIHRyZWUgaW4gbGluZToKPj4+PiAvKiBPdmVyZmxv
dyBhZnRlciB+MFVMICovCj4+Pj4gaWYgKCFpbmRleCkKPj4+PiAgIHJldHVybiBOVUxMOwo+Pj4+
Cj4+Pgo+Pj4gQSBmcmVzaCBjdXJyZW50IGV4YW1wbGUgd2l0aCBsYXRlc3QgZ2l0IHRyZWUgc2hv
d3MgdGhhdCBsaW5lcyA3NjkgYW5kIDc3MCBkbyBhbHRlcm5hdGUgOgo+Pgo+PiBDYW4geW91IHBs
ZWFzZSBhc2sgZ2RiIGZvciB0aGUgdmFsdWUgb2Ygb2Zmc2V0Pwo+Pgo+PiBUaGFua3MsCj4+IC8v
cmljaGFyZAo+Pgo+IAo+IFN0aWxsIHRyeWluZyB0byBnZXQgdGhvc2UgdmFsdWVzLiBPbmUgYXR0
ZW1wdCB0byBkbyB0aGF0IHdhcyB0byByZXBsYWNlIC1PMiB3aXRoIC1PMCBpbiB0aGUgTWFrZWZp
bGUsCj4gYnV0IHRoYXQgcmVzdWx0ZWQgaW50byB0aGlzIGVycm9yIDoKPiAKPiAgIExEICAgICAg
a2VybmVsL2J1aWx0LWluLm8KPiAgIENDICAgICAgbW0vbWVtb3J5Lm8KPiBJbiBmdW5jdGlvbiDi
gJh6YXBfcG1kX3Jhbmdl4oCZLAo+ICAgICBpbmxpbmVkIGZyb20g4oCYemFwX3B1ZF9yYW5nZeKA
mSBhdCBtbS9tZW1vcnkuYzoxMjY1OjgsCj4gICAgIGlubGluZWQgZnJvbSDigJh1bm1hcF9wYWdl
X3Jhbmdl4oCZIGF0IG1tL21lbW9yeS5jOjEyOTA6ODoKPiBtbS9tZW1vcnkuYzoxMjIwOjIzOiBl
cnJvcjogY2FsbCB0byDigJhfX2NvbXBpbGV0aW1lX2Fzc2VydF8xMjIw4oCZIGRlY2xhcmVkIHdp
dGggYXR0cmlidXRlIGVycm9yOiBCVUlMRF9CVUcgZmFpbGVkCj4gbW0vbWVtb3J5LmM6IEluIGZ1
bmN0aW9uIOKAmGZvbGxvd19wYWdlX21hc2vigJk6Cj4gbW0vbWVtb3J5LmM6MTUzMDoxODogZXJy
b3I6IGNhbGwgdG8g4oCYX19jb21waWxldGltZV9hc3NlcnRfMTUzMOKAmSBkZWNsYXJlZCB3aXRo
IGF0dHJpYnV0ZSBlcnJvcjogQlVJTERfQlVHIGZhaWxlZAo+IG1ha2VbMV06ICoqKiBbbW0vbWVt
b3J5Lm9dIEVycm9yIDEKPiBtYWtlOiAqKiogW21tXSBFcnJvciAyCj4gCj4gCj4gV2l0aCAtTzEg
aXQgY29tcGlsZWQgYXQgbGVhc3QuCgpZb3UgY2Fubm90IGJ1aWxkIExpbnV4IHdpdGggLU8xL08w
LgpUcnkgcHJpbnRpbmcgdGhlIHZhbHVlIHVzaW5nIHByaW50ay4uLgoKVGhhbmtzLAovL3JpY2hh
cmQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpOb3ZlbWJlciBXZWJpbmFycyBmb3IgQywgQysrLCBG
b3J0cmFuIERldmVsb3BlcnMKQWNjZWxlcmF0ZSBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSB3aXRo
IHNjYWxhYmxlIHByb2dyYW1taW5nIG1vZGVscy4gRXhwbG9yZQp0ZWNobmlxdWVzIGZvciB0aHJl
YWRpbmcsIGVycm9yIGNoZWNraW5nLCBwb3J0aW5nLCBhbmQgdHVuaW5nLiBHZXQgdGhlIG1vc3Qg
CmZyb20gdGhlIGxhdGVzdCBJbnRlbCBwcm9jZXNzb3JzIGFuZCBjb3Byb2Nlc3NvcnMuIFNlZSBh
YnN0cmFjdHMgYW5kIHJlZ2lzdGVyCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2Ft
cGFkL2Nsaz9pZD02MDEzNjIzMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFp
bGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4
LWRldmVsCg==

