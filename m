Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1Lh2i3-0005Ls-IG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 14:13:31 +0000
Received: from ti-out-0910.google.com ([209.85.142.186])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lh2hy-0006K6-IU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 14:13:31 +0000
Received: by ti-out-0910.google.com with SMTP id a6so1838080tib.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Mar 2009 07:13:23 -0700 (PDT)
Date: Tue, 10 Mar 2009 22:13:52 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090310141352.GD3157@hack>
References: <49AFC206.9080004@panasas.com> <20090305130610.GA4265@hack.private>
	<49AFD780.8080500@panasas.com> <20090305160447.GB4265@hack.private>
	<49B00B83.20400@panasas.com> <20090306075211.GN22605@hack.private>
	<49B3A2AC.7050701@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49B3A2AC.7050701@panasas.com>
Subject: Re: [uml-devel] um: WARNING: vmlinux: 'memcpy' exported twice.
	Previous export	was in vmlinux
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gU3VuLCBNYXIgMDgsIDIwMDkgYXQgMTI6NDk6MTZQTSArMDIwMCwgQm9heiBIYXJyb3NoIHdy
b3RlOgo+QW3DqXJpY28gV2FuZyB3cm90ZToKPj4gT24gVGh1LCBNYXIgMDUsIDIwMDkgYXQgMDc6
Mjc6MzFQTSArMDIwMCwgQm9heiBIYXJyb3NoIHdyb3RlOgo+Pj4gQW3DqXJpY28gV2FuZyB3cm90
ZToKPj4+PiBPbiBUaHUsIE1hciAwNSwgMjAwOSBhdCAwMzo0NTozNlBNICswMjAwLCBCb2F6IEhh
cnJvc2ggd3JvdGU6Cj4+Pj4+IEFtw6lyaWNvIFdhbmcgd3JvdGU6Cj4+Pj4+PiBPbiBUaHUsIE1h
ciAwNSwgMjAwOSBhdCAwMjoxMzo1OFBNICswMjAwLCBCb2F6IEhhcnJvc2ggd3JvdGU6Cj4+Pj4+
Pj4gT24gdG9kYXkncyBsaW51cyB2Mi42LjI5LXJjNy0zLWc1NTk1OTVhCj4+Pj4+Pj4KPj4+Pj4+
PiBEb2luZyBtYWtlIEFSQ0g9dW0gZGVmY29uZmlnICYgbWFrZSBBUkNIPXVtCj4+Pj4+Pj4gZ2l2
ZSdzIG1lOgo+Pj4+Pj4+Cj4+Pj4+Pj4gTEQgdm1saW51eC5vCj4+Pj4+Pj4gTU9EUE9TVCB2bWxp
bnV4Lm8KPj4+Pj4+PiBXQVJOSU5HOiB2bWxpbnV4OiAnbWVtY3B5JyBleHBvcnRlZCB0d2ljZS4g
UHJldmlvdXMgZXhwb3J0IHdhcyBpbiB2bWxpbnV4Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFNv
cnJ5IGlmIHRoaXMgaXMgYSBkdXBsaWNhdGUgcmVwb3J0Cj4+Pj4+Pj4KPj4+Pj4+IFdlaXJkLi4u
Cj4+Pj4+PiBJIHRyaWVkIHRvIGNvbXBpbGUgbGlrZSB3aGF0IHlvdSBzYWlkLCBJIGNhbid0IHJl
cHJvZHVjZSBpdC4KPj4+Pj4+Cj4+Pj4+PiBXaGljaCBnY2MgYXJlIHlvdSB1c2luZz8KPj4+Pj4+
Cj4+Pj4+PiBUaGFua3MuCj4+Pj4+Pgo+Pj4+PiAkIGdjYyAtLXZlcnNpb24KPj4+Pj4gZ2NjIChH
Q0MpIDQuMy4yIDIwMDgxMTA1IChSZWQgSGF0IDQuMy4yLTcpCj4+Pj4+Cj4+Pj4+IEknbSBydW5u
aW5nIG9uIGFuIHg4Nl82NCBGZWRvcmExMCBzeXN0ZW0gKHVwZGF0ZWQgcmVjZW50bHkpCj4+Pj4+
ICQgdW5hbWUgLW8gLXMgLXIgLW0gLXAgLWkKPj4+Pj4gTGludXggMi42LjI3LjE1LTE3MC4yLjI0
LmZjMTAueDg2XzY0IHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAo+Pj4+Pgo+Pj4+IEkg
YW0gdXNpbmcgdGhlIHNhbWUgdGhpbmcsIGJ1dCBvbiBpMzg2LiBJIHN0aWxsIGNhbid0IHJlcHJv
ZHVjZSBpdC4gOigKPj4+Pgo+Pj4gV2hhdCBjYW4gSSBzYXkgSSBqdXN0IGRpZCBpdCBhZ2FpbiBm
cm9tIHNjcmF0Y2gKPj4+Cj4+PiAkIG1rZGlyIC5idWlsZF91bQo+Pj4gJCBtYWtlIEFSQ0g9dW0g
S0JVSUxEX09VVFBVVD0uYnVpbGRfdW0gZGVmY29uZmlnCj4+PiAkIG1ha2UgQVJDSD11bSBLQlVJ
TERfT1VUUFVUPS5idWlsZF91bQo+Pj4KPj4+IChJJ20gdXNpbmcgS0JVSUxEX09VVFBVVD0gYmVj
YXVzZSBPPSBkb2VzIG5vdCB3b3JrIHdoZW4gYWxzbyB1c2luZyBNPSB3aXRoCj4+PiBleHRlcm5h
bCBtb2R1bGVzLCBzbyBpdCdzIGEgaGFiaXQpCj4+Pgo+Pj4gVGhhbmtzIGZvciB5b3VyIGhlbHAu
IEkgd2lsbCB0cnkgdG8gYmlzZWN0IGl0IG9uIFN1bmRheQo+PiAKPj4gSGksIEJvYXouCj4+IAo+
PiBJIGFtIHNvcnJ5IHRoYXQgSSBkb24ndCBoYXZlIGFuIHg4Nl82NCBtYWNoaW5lIHRvIHVzZSwg
YnV0IEkga25vdwo+PiB3aHkgdGhpcyBoYXBwZW5zIG5vdy4gOikKPj4gCj4+IFdvdWxkIHlvdSBs
aWtlIHRvIHRyeSB0aGUgZm9sbG93aW5nIHBhdGNoPyBUaGFua3MhCj4+IAo+PiAtLS0tLS0tLS0t
LS0tLT4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFdBTkcgQ29uZyA8eGl5b3Uud2FuZ2NvbmdAZ21h
aWwuY29tPgo+PiAKPgo+VGVzdGVkLWJ5OiBCb2F6IEhhcnJvc2ggPGJoYXJyb3NoQHBhbmFzYXMu
Y29tPgo+CgpUaGFuayB5b3UuCgpJIHdpbGwgcmVzZW5kIHRoYXQgcGF0Y2ggd2l0aCB5b3VyIFRl
c3RlZC1ieS4gOikKCj4+IC0tLQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9vcy1MaW51eC91c2Vy
X3N5bXMuYyBiL2FyY2gvdW0vb3MtTGludXgvdXNlcl9zeW1zLmMKPj4gaW5kZXggNzRmNDliYi4u
ODliNDhhMSAxMDA2NDQKPj4gLS0tIGEvYXJjaC91bS9vcy1MaW51eC91c2VyX3N5bXMuYwo+PiAr
KysgYi9hcmNoL3VtL29zLUxpbnV4L3VzZXJfc3ltcy5jCj4+IEBAIC0xNCw3ICsxNCw2IEBACj4+
ICAjdW5kZWYgbWVtc2V0Cj4+ICAKPj4gIGV4dGVybiBzaXplX3Qgc3RybGVuKGNvbnN0IGNoYXIg
Kik7Cj4+IC1leHRlcm4gdm9pZCAqbWVtY3B5KHZvaWQgKiwgY29uc3Qgdm9pZCAqLCBzaXplX3Qp
Owo+PiAgZXh0ZXJuIHZvaWQgKm1lbW1vdmUodm9pZCAqLCBjb25zdCB2b2lkICosIHNpemVfdCk7
Cj4+ICBleHRlcm4gdm9pZCAqbWVtc2V0KHZvaWQgKiwgaW50LCBzaXplX3QpOwo+PiAgZXh0ZXJu
IGludCBwcmludGYoY29uc3QgY2hhciAqLCAuLi4pOwo+PiBAQCAtMjQsNyArMjMsMTEgQEAgZXh0
ZXJuIGludCBwcmludGYoY29uc3QgY2hhciAqLCAuLi4pOwo+PiAgRVhQT1JUX1NZTUJPTChzdHJz
dHIpOwo+PiAgI2VuZGlmCj4+ICAKPj4gKyNpZm5kZWYgX194ODZfNjRfXwo+PiArZXh0ZXJuIHZv
aWQgKm1lbWNweSh2b2lkICosIGNvbnN0IHZvaWQgKiwgc2l6ZV90KTsKPj4gIEVYUE9SVF9TWU1C
T0wobWVtY3B5KTsKPj4gKyNlbmRpZgo+PiArCj4+ICBFWFBPUlRfU1lNQk9MKG1lbW1vdmUpOwo+
PiAgRVhQT1JUX1NZTUJPTChtZW1zZXQpOwo+PiAgRVhQT1JUX1NZTUJPTChwcmludGYpOwo+PiAg
Cj4KPlllcyB0aGlzIHdvcmtzLiBCdXQgaXQgaXMgd2VpcmQsIHdoYXQgaXMgdGhlIGRpZmZlcmVu
Y2UgYmV0d2Vlbgo+X194ODZfNjRfXyBhbmQgYW55IG90aGVyIHBsYXRmb3JtPwoKSSBqdXN0IHNh
dyB0aGUgY29tbWVudHMgaW4gYXJjaC91bS9zeXMteDg2XzY0L2tzeW1zLmMuCgotLSAKRG8gd2hh
dCB5b3UgbG92ZSwgZioqayB0aGUgcmVzdCEgRioqayB0aGUgcmVndWxhdGlvbnMhCiAKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51
eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

