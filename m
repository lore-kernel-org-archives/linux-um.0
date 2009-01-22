Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LQ2BD-0005t8-Dm
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 16:13:19 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LQ2B7-0003s9-DQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 16:13:19 +0000
Received: by ewy14 with SMTP id 14so3243683ewy.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2009 08:13:10 -0800 (PST)
Date: Fri, 23 Jan 2009 00:12:57 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090122161257.GG9732@hack.private>
References: <20090115194033.GA10926@hack.private>
	<200901170328.15178.rob@landley.net>
	<20090118083237.GA3292@hack.private>
	<200901181729.31682.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200901181729.31682.rob@landley.net>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: Rob Landley <rob@landley.net>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

T24gU3VuLCBKYW4gMTgsIDIwMDkgYXQgMDU6Mjk6MzBQTSAtMDYwMCwgUm9iIExhbmRsZXkgd3Jv
dGU6Cj5PbiBTdW5kYXkgMTggSmFudWFyeSAyMDA5IDAyOjMyOjM3IEFtw6lyaWNvIFdhbmcgd3Jv
dGU6Cj4+ID5UaGUgcmVzdWx0IHBhbmljcyAodHdpY2UpIGFuZCBleGl0cywgaW5zdGVhZCBvZiBn
aXZpbmcgbWUgYSBzaGVsbCBwcm9tcHQuCj4+ID5CdWlsdCBhbmQgcnVuIG9uIHN0b2NrIFVidW50
dSA4LjEwLiAgKEkgcG9zdGVkIGFib3V0IGl0IG9uIHR1ZXNkYXksIGJ1dAo+PiA+IG5vYm9keSBy
ZXBsaWVkLi4uKQo+Pgo+PiBIaSwgUm9iLgo+Pgo+PiBJIHRyaWVkIHdoYXQgeW91IHNhaWQsIGl0
IHdvcmtzIHZlcnkgZmluZSBoZXJlLCBvbiBteSBGZWRvcmEgMTAuCj4+IENvdWxkIHlvdSBwbGVh
c2UgdGVsbCB1cyB3aGljaCBrZXJuZWwgeW91ciBob3N0IGlzIHVzaW5nPwo+Cj5VYnVudHUgOC4x
MCBzdG9jayBrZXJuZWwsIGNhbGxzIGl0c2VsZiAiMi42LjI3LTktZ2VuZXJpYyIuCj4KPj4gYW5k
IHRoZSBndWVzdD8KPgo+Q2hlY2tpbmcgdHVlc2RheSdzIGJ1ZyByZXBvcnQsIGl0IHNhaWQ6Cj4K
Pj4gTGludXggdmVyc2lvbiAyLjYuMjggKGxhbmRsZXlAZHJpZnR3b29kKSAoZ2NjIHZlcnNpb24g
NC4zLjIgKFVidW50dSAKPj4gNC4zLjItMXVidW50dTExKSApICM2IFR1ZSBKYW4gMTMgMDE6NTQ6
MzQgQ1NUIDIwMDkKPgo+SXQncyB0aGUgdmFuaWxsYSB0YXJiYWxsIChhbGJlaXQgZXh0cmFjdGVk
IGZyb20gc291cmNlIGNvbnRyb2wgYWNjb3JkaW5nIHRvIAo+dGhlIHYyLjYuMjggdGFnIHJhdGhl
ciB0aGFuIGRvd25sb2FkZWQpLgoKSSB3aWxsIHRyeSAyLjYuMjguCgo+Cj5Qb3NzaWJseSBhIGdj
YyA0LjMgaXNzdWU/CgpJIGRvbid0IGtub3cuIDopCgotLSAKIkFnYWluc3Qgc3R1cGlkaXR5LCB0
aGUgZ29kcyB0aGVtc2VsdmVzLCBjb250ZW5kIGluIHZhaW4uIgoKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnk6ClNvdXJjRm9yZ2UgQ29tbXVu
aXR5ClNvdXJjZUZvcmdlIHdhbnRzIHRvIHRlbGwgeW91ciBzdG9yeS4KaHR0cDovL3Auc2YubmV0
L3NmdS9zZi1zcHJlYWR0aGV3b3JkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2Rl
LWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK
