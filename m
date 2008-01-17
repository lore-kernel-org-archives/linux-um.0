Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFVFz-0006cY-UX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 05:58:12 -0800
Received: from ag-out-0708.google.com ([72.14.246.247])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFVFu-0001lJ-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 05:58:06 -0800
Received: by ag-out-0708.google.com with SMTP id 26so179787agb.5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jan 2008 05:58:05 -0800 (PST)
Date: Thu, 17 Jan 2008 21:56:41 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080117135641.GD2693@hacking>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Subject: [uml-devel] [-mm Patch] uml: fix a building error
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

ClRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBidWlsZGluZyBlcnJvcjoKLi4uCmRyaXZlcnMvY2hhci9t
ZW0uYzogSW4gZnVuY3Rpb24g4oCYcmVhZF9tZW3igJk6CmRyaXZlcnMvY2hhci9tZW0uYzoxMzY6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh1bnhsYXRlX2Rldl9t
ZW1fcHRy4oCZCi4uLgoKQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRkdG9pdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IFdBTkcgQ29uZyA8eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tPgoKLS0tCgpJbmRleDog
bGludXgvaW5jbHVkZS9hc20tdW0vaW8uaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC5vcmlnL2luY2x1
ZGUvYXNtLXVtL2lvLmgKKysrIGxpbnV4L2luY2x1ZGUvYXNtLXVtL2lvLmgKQEAgLTI3LDYgKzI3
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkICogcGh5c190b192aXJ0KHVuc2lnbgogICogYWNjZXNz
CiAgKi8KICNkZWZpbmUgeGxhdGVfZGV2X21lbV9wdHIocCkJX192YShwKQorI2RlZmluZSB1bnhs
YXRlX2Rldl9tZW1fcHRyKHAsIHB0cikKIAogLyoKICAqIENvbnZlcnQgYSB2aXJ0dWFsIGNhY2hl
ZCBwb2ludGVyIHRvIGFuIHVuY2FjaGVkIHBvaW50ZXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBT
Ri5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OiBNaWNyb3NvZnQKRGVmeSBhbGwgY2hhbGxlbmdl
cy4gTWljcm9zb2Z0KFIpIFZpc3VhbCBTdHVkaW8gMjAwOC4KaHR0cDovL2Nsay5hdGRtdC5jb20v
TVJUL2dvL3ZzZTAxMjAwMDAwNzBtcnQvZGlyZWN0LzAxLwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBs
aXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVs
Cg==
