Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xto7-0005F3-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 12:42:15 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xto6-0001xe-48
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 12:42:14 -0700
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
Message-ID: <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk>
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1063395711=:4368"
Subject: [uml-devel] Re: uml segfaults on redhat beta "severn"
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
Date: Fri, 12 Sep 2003 20:41:51 +0100 (BST)
To: User-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1063395711=:4368
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 10 Sep 2003, M A Young wrote:

> If you try to run a uml kernel under a 2.4 kernel from the redhat beta
> "severn" in tt mode, you get an almost immediate crash, under
> before_mem_tt, in the final remap_data call. The problem is that it seem
> in these kernels, maybe as a result of the new "exec-shield" feature, that
> the code and data segments are no longer adjacent, which means that from
> __bss_start to sbrk(0) is around 26Mb rather than under 1Mb, including
> bits it presumably has no right to copy, hence the segfault.
> This will presumably also apply to Red Hat's next release, assuming they
> keep the same features.

To give you a better idea of what the problem is, below are some addresses
and memory maps (/proc/???/maps). I also am attaching an example patch
which seems to fix the problem by using &_end instead of brk_start in
the final remap_data.

	Michael Young

good host kernel (RH9)
----------------------
_stext=0xa0002000
_etext=0xa01b53c0
_sdata=0xa01b6000
_edata=0xa01d7000
__bss_start(rounded?)=0xa01d7000
brk_start=0xa02cd000

maps at 3rd remap_data
40000000-40001000 rw-p 00000000 00:00 0
a0000000-a0002000 rwxp 00000000 03:07 195518     /home/michael/uml/linux-2.4.22-3um
a0002000-a01b6000 rwxs 00000000 03:07 245959     /tmp/vm_file-S4MHZL (deleted)
a01b6000-a01d7000 rwxs 00000000 03:07 246258     /tmp/vm_file-j14l1c (deleted)
a01d7000-a02cd000 rwxp 00000000 00:00 0
bfffc000-c0000000 rwxp ffffd000 00:00 0

bad host kernel (severn)
------------------------
_stext=0xa0002000
_etext=0xa01b53c0
_sdata=0xa01b6000
_edata=0xa01d7000
__bss_start(rounded?)=0xa01d7000
brk_start=0xa0a14000

maps at 3rd remap_data
a0000000-a0002000 rwxp 00000000 03:07 195518     /home/michael/uml/linux-2.4.22-3um
a0002000-a01b6000 rwxs 00000000 03:07 245959     /tmp/vm_file-5zQ7YU (deleted)
a01b6000-a01d7000 rwxs 00000000 03:07 246258     /tmp/vm_file-l5O9bi (deleted)
a01d7000-a02cc000 rw-p 00000000 00:00 0
a0a13000-a0a14000 rw-p 00000000 00:00 0
bf39d000-bf39e000 rw-p 00000000 00:00 0
bfee7000-c0000000 rwxp fffcf000 00:00 0

maps at segfault
a0000000-a0002000 rwxp 00000000 03:07 195518     /home/michael/uml/linux-2.4.22-3um
a0002000-a01b6000 rwxs 00000000 03:07 245959     /tmp/vm_file-5zQ7YU (deleted)
a01b6000-a01d7000 rwxs 00000000 03:07 246258     /tmp/vm_file-l5O9bi (deleted)
a01d7000-a02cc000 rw-p 00000000 00:00 0
a0a13000-a0a14000 rw-p 00000000 00:00 0
beb60000-bf39d000 rw-s 00000000 03:07 247343     /tmp/vm_file-gy3mtk (deleted)
bf39d000-bf39e000 rw-p 00000000 00:00 0
bfee7000-c0000000 rwxp fffcf000 00:00 0

---559023410-851401618-1063395711=:4368
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="severncrash.patch"
Content-Description: 
Content-Disposition: attachment; filename="severncrash.patch"
Content-Transfer-Encoding: BASE64

ZGlmZiAtTmF1ciBsaW51eC0vYXJjaC91bS9rZXJuZWwvdHQvbWVtLmMgbGlu
dXgrL2FyY2gvdW0va2VybmVsL3R0L21lbS5jDQotLS0gbGludXgtL2FyY2gv
dW0va2VybmVsL3R0L21lbS5jCTIwMDMtMDktMTIgMjA6MTI6MTIuMDAwMDAw
MDAwICswMTAwDQorKysgbGludXgrL2FyY2gvdW0va2VybmVsL3R0L21lbS5j
CTIwMDMtMDktMTIgMjA6MDY6MDYuMDAwMDAwMDAwICswMTAwDQpAQCAtMTgs
NyArMTgsNyBAQA0KIAlpZighamFpbCB8fCBkZWJ1ZykNCiAJCXJlbWFwX2Rh
dGEoVU1MX1JPVU5EX0RPV04oJl9zdGV4dCksIFVNTF9ST1VORF9VUCgmX2V0
ZXh0KSwgMSk7DQogCXJlbWFwX2RhdGEoVU1MX1JPVU5EX0RPV04oJl9zZGF0
YSksIFVNTF9ST1VORF9VUCgmX2VkYXRhKSwgMSk7DQotCXJlbWFwX2RhdGEo
VU1MX1JPVU5EX0RPV04oJl9fYnNzX3N0YXJ0KSwgVU1MX1JPVU5EX1VQKGJy
a19zdGFydCksIDEpOw0KKwlyZW1hcF9kYXRhKFVNTF9ST1VORF9ET1dOKCZf
X2Jzc19zdGFydCksIFVNTF9ST1VORF9VUCgmX2VuZCksIDEpOw0KIH0NCiAN
CiAjaWZkZWYgQ09ORklHX0hPU1RfMkdfMkcNCg==

---559023410-851401618-1063395711=:4368--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
