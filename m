Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QObox-0005C4-PD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2011 20:33:47 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QObow-0006to-4S
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2011 20:33:47 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 23 May 2011 22:30:52 +0200
Message-Id: <1306182652-25493-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH] um: use RWSEM_GENERIC_SPINLOCK on x86
To: akpm@linux-foundation.org
Cc: #, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, torvalds@linux-foundation.org, stable@kernel.org

Q29tbWl0IGQxMjMzNyAocndzZW06IFJlbW92ZSByZWR1bmRhbnQgYXNtcmVncGFybSBhbm5vdGF0
aW9uKQpicm9rZSByd3NlbSBvbiBVTUwuCkFzIHdlIGNhbm5vdCBjb21waWxlIFVNTCB3aXRoIC1t
cmVncGFybT0zIGFuZCBrZWVwaW5nIGFzbXJlZ3Bhcm0gb25seQpmb3IgVU1MIGlzIGluYWRlcXVh
dGUgdGhlIGVhc2llc3Qgc29sdXRpb24gaXMgdXNpbmcgUldTRU1fR0VORVJJQ19TUElOTE9DSy4K
ClRoYW5rcyB0byBUaG9tYXMgR2xlaXhuZXIgZm9yIHRoZSBpZGVhLgoKUmVwb3J0ZWQtYnk6IFRv
cmFsZiBGw7Zyc3RlciA8dG9yYWxmLmZvZXJzdGVyQGdteC5kZT4KVGVzdGVkLWJ5OiBUb3JhbGYg
RsO2cnN0ZXIgPHRvcmFsZi5mb2Vyc3RlckBnbXguZGU+CkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4KQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4gIyAuMzkueApTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgotLS0KIGFyY2gvdW0v
S2NvbmZpZy54ODYgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vS2NvbmZpZy54ODYgYi9hcmNo
L3VtL0tjb25maWcueDg2CmluZGV4IGE5ZGE1MTYuLmQ1N2NmOWMgMTAwNjQ0Ci0tLSBhL2FyY2gv
dW0vS2NvbmZpZy54ODYKKysrIGIvYXJjaC91bS9LY29uZmlnLng4NgpAQCAtMjksMTAgKzI5LDEw
IEBAIGNvbmZpZyBYODZfNjQKIAlkZWZfYm9vbCA2NEJJVAogCiBjb25maWcgUldTRU1fWENIR0FE
RF9BTEdPUklUSE0KLQlkZWZfYm9vbCBYODZfWEFERAorCWRlZl9ib29sIFg4Nl9YQUREICYmIDY0
QklUCiAKIGNvbmZpZyBSV1NFTV9HRU5FUklDX1NQSU5MT0NLCi0JZGVmX2Jvb2wgIVg4Nl9YQURE
CisJZGVmX2Jvb2wgIVg4Nl9YQUREIHx8ICE2NEJJVAogCiBjb25maWcgM19MRVZFTF9QR1RBQkxF
UwogCWJvb2wgIlRocmVlLWxldmVsIHBhZ2V0YWJsZXMgKEVYUEVSSU1FTlRBTCkiIGlmICE2NEJJ
VAotLSAKMS43LjQuMgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpXaGF0IEV2ZXJ5IEMvQysrIGFu
ZCBGb3J0cmFuIGRldmVsb3BlciBTaG91bGQgS25vdyEKUmVhZCB0aGlzIGFydGljbGUgYW5kIGxl
YXJuIGhvdyBJbnRlbCBoYXMgZXh0ZW5kZWQgdGhlIHJlYWNoIG9mIGl0cyAKbmV4dC1nZW5lcmF0
aW9uIHRvb2xzIHRvIGhlbHAgV2luZG93cyogYW5kIExpbnV4KiBDL0MrKyBhbmQgRm9ydHJhbiAK
ZGV2ZWxvcGVycyBib29zdCBwZXJmb3JtYW5jZSBhcHBsaWNhdGlvbnMgLSBpbmNsdWRpbmcgY2x1
c3RlcnMuIApodHRwOi8vcC5zZi5uZXQvc2Z1L2ludGVsLWRldjJkZXZtYXkKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVs
IG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1s
aW51eC1kZXZlbAo=

