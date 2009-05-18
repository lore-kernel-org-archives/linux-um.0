Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1M5zNq-0003CF-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 May 2009 09:43:46 +0000
Received: from mail-pz0-f110.google.com ([209.85.222.110])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5zNp-00045D-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 May 2009 09:43:46 +0000
Received: by pzk8 with SMTP id 8so2454960pzk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 18 May 2009 02:43:43 -0700 (PDT)
Date: Mon, 18 May 2009 17:45:01 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090518094501.GB13776@cr0.nay.redhat.com>
References: <20090316074520.GC3360@hack> <20090324234753.GH22695@cs.unibo.it>
	<20090329163228.GE7671@hack> <20090404101708.GG4203@cs.unibo.it>
	<20090407173646.GL12226@hack> <20090408121851.GE24173@cs.unibo.it>
	<20090413163603.GG2391@hack> <20090417081823.GA31897@hack>
	<20090425091928.GB18153@cs.unibo.it> <20090430082711.GA24819@hack>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090430082711.GA24819@hack>
Subject: Re: [uml-devel] [PATCH 0/2] ptrace_vm: ptrace for syscall emulation
	virtual	machines
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
To: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, mtk.manpages@gmail.com, akpm@linux-foundation.org, Roland McGrath <roland@redhat.com>

T24gVGh1LCBBcHIgMzAsIDIwMDkgYXQgMDQ6Mjc6MTFQTSArMDgwMCwgQW3DqXJpY28gV2FuZyB3
cm90ZToKPk9uIFNhdCwgQXByIDI1LCAyMDA5IGF0IDExOjE5OjI4QU0gKzAyMDAsIFJlbnpvIERh
dm9saSB3cm90ZToKPgo+Pgo+PkkgaGF2ZSBzdWNjZXNzZnVsbHkgdGVzdGVkIG15IHBhY2hlcyBp
biB2YXJpb3VzIGNvbmZpZ3VyYXRpb25zOgo+Pi0gcGF0Y2hlZC1rZXJuZWwgcnVubmluZyBwYXRj
aGVkLVVNTAo+Pi0gcGF0Y2hlZC1rZXJuZWwgcnVubmluZyB1bnBhdGNoZWQtVU1MCj4+LSBwYXRj
aGVkLWtlcm5lbCBydW5uaW5nIHVtdmlldwo+Pi0gcGF0Y2hlZC1VTUwgcnVubmluZyB1bXZpZXcK
Pj4tIFVNTCBvbiBVTUwgZmFpbHMgaW4gdGhlIHNhbWUgd2F5IHdpdGggYW5kIHdpdGhvdXQgdGhl
IHBhdGNoLgo+PkkgYW0gY3VycmVudGx5IHJ1bm5pbmcgdGhlIHBhdGNoZWQga2VybmVsIG9uIG15
IGxhcHRvcC4KPgo+VGhhbmtzLCBJIHdpbGwgZ2l2ZSB0aGVtIGFub3RoZXIgdGVzdGluZyBzb29u
Li4uCgpTb3JyeSBmb3IgdGhlIGxvbmcgZGVsYXkuLi4KCkkgcmV2aWV3ZWQgdGhlIHdob2xlIHBh
dGNoIHNldCBhZ2FpbiwgYW5kIHRlc3RlZCBpdCBvbiBib3RoIGkzODYKYW5kIHg4Nl82NCwgaXQg
bG9va3MgdmVyeSBmaW5lISEgOi0pCgpTbyBJIHdvdWxkIGxpa2UgdG8gc2VlIHRoZXNlIHBhdGNo
ZXMgdG8gYmUgbWVyZ2VkLgoKQW5kcmV3LCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgdGhlc2UgdHdv
IHBhdGNoZXMgZm9yIHVzPz8KClRoYW5rIHlvdSEKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ3J5
c3RhbCBSZXBvcnRzIC0gTmV3IEZyZWUgUnVudGltZSBhbmQgMzAgRGF5IFRyaWFsCkNoZWNrIG91
dCB0aGUgbmV3IHNpbXBsaWZpZWQgbGljZW5zaW5nIG9wdGlvbiB0aGF0IGVuYWJsZXMgCnVubGlt
aXRlZCByb3lhbHR5LWZyZWUgZGlzdHJpYnV0aW9uIG9mIHRoZSByZXBvcnQgZW5naW5lIApmb3Ig
ZXh0ZXJuYWxseSBmYWNpbmcgc2VydmVyIGFuZCB3ZWIgZGVwbG95bWVudC4gCmh0dHA6Ly9wLnNm
Lm5ldC9zZnUvYnVzaW5lc3NvYmplY3RzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1t
b2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

