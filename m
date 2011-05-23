Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QOc8G-0007WN-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2011 20:53:44 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QOc8E-0007bx-QB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2011 20:53:44 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 23 May 2011 22:51:33 +0200
Message-Id: <1306183893-26655-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH v2] um: use RWSEM_GENERIC_SPINLOCK on x86
To: akpm@linux-foundation.org
Cc: #, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, stable@kernel.org

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
L3VtL0tjb25maWcueDg2CmluZGV4IGE5ZGE1MTYuLjc5NWVhOGUgMTAwNjQ0Ci0tLSBhL2FyY2gv
dW0vS2NvbmZpZy54ODYKKysrIGIvYXJjaC91bS9LY29uZmlnLng4NgpAQCAtMjksMTAgKzI5LDEw
IEBAIGNvbmZpZyBYODZfNjQKIAlkZWZfYm9vbCA2NEJJVAogCiBjb25maWcgUldTRU1fWENIR0FE
RF9BTEdPUklUSE0KLQlkZWZfYm9vbCBYODZfWEFERAorCWRlZl9ib29sIFg4Nl9YQUREICYmIDY0
QklUCiAKIGNvbmZpZyBSV1NFTV9HRU5FUklDX1NQSU5MT0NLCi0JZGVmX2Jvb2wgIVg4Nl9YQURE
CisJZGVmX2Jvb2wgIVJXU0VNX1hDSEdBRERfQUxHT1JJVEhNCiAKIGNvbmZpZyAzX0xFVkVMX1BH
VEFCTEVTCiAJYm9vbCAiVGhyZWUtbGV2ZWwgcGFnZXRhYmxlcyAoRVhQRVJJTUVOVEFMKSIgaWYg
ITY0QklUCi0tIAoxLjcuNC4yCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCldoYXQgRXZlcnkgQy9D
KysgYW5kIEZvcnRyYW4gZGV2ZWxvcGVyIFNob3VsZCBLbm93IQpSZWFkIHRoaXMgYXJ0aWNsZSBh
bmQgbGVhcm4gaG93IEludGVsIGhhcyBleHRlbmRlZCB0aGUgcmVhY2ggb2YgaXRzIApuZXh0LWdl
bmVyYXRpb24gdG9vbHMgdG8gaGVscCBXaW5kb3dzKiBhbmQgTGludXgqIEMvQysrIGFuZCBGb3J0
cmFuIApkZXZlbG9wZXJzIGJvb3N0IHBlcmZvcm1hbmNlIGFwcGxpY2F0aW9ucyAtIGluY2x1ZGlu
ZyBjbHVzdGVycy4gCmh0dHA6Ly9wLnNmLm5ldC9zZnUvaW50ZWwtZGV2MmRldm1heQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgt
ZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1t
b2RlLWxpbnV4LWRldmVsCg==

