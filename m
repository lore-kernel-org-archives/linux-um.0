Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ywOl-0005bE-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 09:40:23 -0700
Received: from bay7-f56.bay7.hotmail.com ([64.4.11.56] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ywOl-0007C3-6p
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 09:40:23 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Re: 2.4.22-4um race condition
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_2eff_1679_25ae"
Message-ID: <BAY7-F56ob7bOsPTQxH0002321c@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 15 Sep 2003 16:39:50 +0000
To: rocombs@cs.nmsu.edu
Cc: User-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.

------=_NextPart_000_2eff_1679_25ae
Content-Type: text/plain; format=flowed

rocombs@cs.nmsu.edu wrote:
>The "correct" fix seems to have completely removed the errors.
>I just moved these two lines:
>
>        kernel_fd = fds[0];
>        *fd_out = fds[1];
>
>to before the clone() in ubd_user.c.  Is this correct?

There's a few things I noticed with start_io_thread, though mostly to do 
with failing cleanly.  Try the attached patch for 2.4.22-4um.

Steve Schmidtke

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail

------=_NextPart_000_2eff_1679_25ae
Content-Type: application/octet-stream; name="ubd_start_io_thread.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ubd_start_io_thread.diff"

LS0tIG9yaWcvYXJjaC91bS9kcml2ZXJzL3ViZF91c2VyLmMJU3VuIFNlcCAx
NCAxNzo0MTo1OCAyMDAzCisrKyBuZXcvYXJjaC91bS9kcml2ZXJzL3ViZF91
c2VyLmMJTW9uIFNlcCAxNSAxMDoxNjoxMyAyMDAzCkBAIC0zNDIsMjQgKzM0
MiwyOSBAQAogCWVyciA9IG9zX3BpcGUoZmRzLCAxLCAxKTsKIAlpZihlcnIg
PCAwKXsKIAkJcHJpbnRrKCJzdGFydF9pb190aHJlYWQgLSBvc19waXBlIGZh
aWxlZCwgZXJyID0gJWRcbiIsIC1lcnIpOwotCQlyZXR1cm4oZXJyKTsKKwkJ
Z290byBlcnJfb3V0OwogCX0KIAorCWtlcm5lbF9mZCA9IGZkc1swXTsKKwog
CXBpZCA9IGNsb25lKGlvX3RocmVhZCwgKHZvaWQgKikgc3AsIENMT05FX0ZJ
TEVTIHwgQ0xPTkVfVk0gfCBTSUdDSExELAogCQkgICAgTlVMTCk7CiAJaWYo
cGlkIDwgMCl7CiAJCXByaW50aygic3RhcnRfaW9fdGhyZWFkIC0gY2xvbmUg
ZmFpbGVkIDogZXJybm8gPSAlZFxuIiwgZXJybm8pOwotCQlnb3RvIGVycjsK
KwkJZXJyID0gLWVycm5vOworCQlnb3RvIGNsb3NlX291dDsKIAl9CiAKLQlr
ZXJuZWxfZmQgPSBmZHNbMF07CiAJKmZkX291dCA9IGZkc1sxXTsKIAogCXJl
dHVybihwaWQpOwotIGVycjoKKworY2xvc2Vfb3V0OgorCWtlcm5lbF9mZCA9
IC0xOwogCW9zX2Nsb3NlX2ZpbGUoZmRzWzBdKTsKIAlvc19jbG9zZV9maWxl
KGZkc1sxXSk7Ci0JcmV0dXJuKC1lcnJubyk7CitlcnJfb3V0OgorCXJldHVy
bihlcnIpOwogfQogCiAvKgo=


------=_NextPart_000_2eff_1679_25ae--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
