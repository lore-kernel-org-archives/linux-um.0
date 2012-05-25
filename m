Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1SXqgn-0000cJ-W0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2012 09:20:05 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXqgk-0000Hv-9a for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2012 09:20:05 +0000
Message-ID: <4FBF4EAB.7030904@panasas.com>
Date: Fri, 25 May 2012 12:19:39 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <161124411.50124.1337931613542.JavaMail.root@sigma-star.at>
In-Reply-To: <161124411.50124.1337931613542.JavaMail.root@sigma-star.at>
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: "Richard RW. Weinberger" <richard@sigma-star.at>
Cc: Weinberger <richard@nod.at>, Richard, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMDUvMjUvMjAxMiAxMDo0MCBBTSwgUmljaGFyZCBSVy4gV2VpbmJlcmdlciB3cm90ZToKCj4g
LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBJJ3ZlIGJlZW4gcnVubmluZyB3aXRo
IHlvdXIgdHR5IHBhdGNoIGZvciBhIHdoaWxlIG5vdywgYW5kIHdhcyBhYmxlCj4+IHRvIHdvcmsu
IDMuMyBLZXJuZWwKPj4KPj4gTm93IGJhc2VkIG9uIDMuNCB0cmVlIHRoZSBwYXRjaCBubyBsb25n
ZXIgbWVyZ2VzLCB0b28gbWFueSBjaGFuZ2VzLgo+PiBCdXQgYW0gYmFjayB0byB0aGUgc2FtZSBj
cmFzaGVzIGFzIGJlZm9yZS4gRG8geW91IGhhdmUgYSByb3VnaAo+PiBwYXRjaCBmb3IgMy40IGJh
c2UgSSBjYW4gdXNlLgo+IAo+IE9rYXksIEknbGwgc2VuZCBhbiB1cGRhdGVkIHZlcnNpb24uCj4g
Q3VycmVudGx5IHRoZSB0dHkgc3ViLXN5c3RlbSBpcyBoZWF2aWx5IGNoYW5nZWQuCj4gCgoKVGhh
bmtzLiAKWWVzIEkgbm90aWNlZCBidW5jaCBvZiBzdHVmZiBtb3ZlZCBhcm91bmQgbm90aGluZyB0
cml2aWFsIHRoYXQgSSBjb3VsZCBmaXgKCgo+IFRoYW5rcywKPiAvL3JpY2hhcmQKCgpXaGF0cyBr
ZWVwaW5nIHRoaXMgcGF0Y2ggZnJvbSBoaXR0aW5nIG1haW5saW5lPyB0byBtdWNoIHVnbGluZXNz
PwpJcyB0aGVyZSBhIHdheSB0byB3b3JrIHdpdGhvdXQgaXQgKHNvbWVob3cpCgpUaGFua3MKQm9h
egoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkgVmlydHVhbCBDb25mZXJlbmNl
CkV4Y2x1c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3YXlzIHRvZGF5J3Mgc2Vj
dXJpdHkgYW5kIAp0aHJlYXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFuZCBob3cgSVQgbWFuYWdl
cnMgY2FuIHJlc3BvbmQuIERpc2N1c3Npb25zIAp3aWxsIGluY2x1ZGUgZW5kcG9pbnQgc2VjdXJp
dHksIG1vYmlsZSBzZWN1cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3YXJlIAp0aHJlYXRzLiBo
dHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJubDA0MjQyMDEyLzExNC81MDEyMjI2My8K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2Rl
LWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L3VzZXItbW9kZS1saW51eC1kZXZlbAo=

