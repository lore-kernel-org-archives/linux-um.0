Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AR1f5-0000GS-2c
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 19:57:19 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AQypB-0000I0-Cw
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 16:55:33 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0312020036530.16157-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0312020123030.16352-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-328070892-1070326447=:16352"
Content-ID: <Pine.LNX.4.44.0312020154130.16473@filer.marasystems.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 2 Dec 2003 01:55:25 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-328070892-1070326447=:16352
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0312020154131.16473@filer.marasystems.com>

On Tue, 2 Dec 2003, Henrik Nordstrom wrote:

> On Mon, 1 Dec 2003, Henrik Nordstrom wrote:
> 
> > I have got so far that it looks like the pte is not modified making me 
> > suspect that there is a old page mapping around initially maybe not 
> > maching the pte after the call to vmalloc().
> 
> This has now been confirmed.
> 
> Now remains to figure out why the mapping of the old page is still 
> around and why the tlb mappings has not been synched.

This too has now been identified, but I am not sure what is the best way 
to fix this.

vfree() calls flush_tlb_all(), but as this does not update the vm_seq
number old the mapping is still there unless there is another page fault
before the page is referenced again. Because of this there is a race if
vmalloc() returns the same area that was last vmfree():d causing that area
to temporarily refer to the old physical location until the next kernel
page fault and quickly resulting in very odd results..

What I wonder is if this can be fixed without dropping the vm_seq
optimization of tt kernel virtual memory updates. But from looking at the
skas implementation I suppose dropping the vm_seq optimization is the
correct way.. (skas does not have this optimization and should thus be
safe from the issue)

I have now removed this vm_seq optimization from my kernel sources and
have verified that the iptables-restore problem is no where to be seen 
with this vm_seq optimization disabled. [silly patch attached just to 
illustrate the problem area]

What was the design thought behind the vm_seq optimization? I understand
the principle, but not the conditions when it can be safely deduced that
the init_mm has not been updated since the last flush_kernel_vm_range().

I still think the kernel vm pte mappings should be mirrored into the
current process and flush_kernel_vm_range() changed to do incremental
remaps where the kernel vm pte mappings of init_mm differs from the
current process. This applies to both tt and skas mode. With the kernel vm
area being very limited in size such optimization should not be very hard
or costly to accomplish and will by far outperform the mm_seq optimization
of tt.. but my understanding of this is still a little limited so it might
well be the case that this is not worth bothering with.

Regards
Henrik

---1463811839-328070892-1070326447=:16352
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="tlb_flush.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0312020154070.16352@filer.marasystems.com>
Content-Description: tlb_flush_all() workaround for TT mode
Content-Disposition: ATTACHMENT; FILENAME="tlb_flush.patch"

SW5kZXg6IGFyY2gvdW0va2VybmVsL3R0L3RsYi5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvdXNlci1tb2RlLWxpbnV4
L2xpbnV4L2FyY2gvdW0va2VybmVsL3R0L3RsYi5jLHYNCnJldHJpZXZpbmcg
cmV2aXNpb24gMS40DQpkaWZmIC11IC13IC1wIC1yMS40IHRsYi5jDQotLS0g
YXJjaC91bS9rZXJuZWwvdHQvdGxiLmMJMjAgRGVjIDIwMDIgMjM6NTQ6NDkg
LTAwMDAJMS40DQorKysgYXJjaC91bS9rZXJuZWwvdHQvdGxiLmMJMiBEZWMg
MjAwMyAwMDo1MTo0MiAtMDAwMA0KQEAgLTE5Nyw3ICsxOTcsOSBAQCB2b2lk
IGZsdXNoX3RsYl9tbV90dChzdHJ1Y3QgbW1fc3RydWN0ICptDQogCWZpeF9y
YW5nZShtbSwgMCwgU1RBQ0tfVE9QLCAwKTsNCiANCiAJc2VxID0gYXRvbWlj
X3JlYWQoJnZtY2hhbmdlX3NlcSk7DQorI2lmIFRISVNfT1BUSU1JWkFUSU9O
X0RPRVNfTk9UX1dPUktfUFJPUEVSTFkNCiAJaWYoY3VycmVudC0+dGhyZWFk
Lm1vZGUudHQudm1fc2VxID09IHNlcSkgcmV0dXJuOw0KKyNlbmRpZg0KIAlj
dXJyZW50LT50aHJlYWQubW9kZS50dC52bV9zZXEgPSBzZXE7DQogCWZsdXNo
X2tlcm5lbF92bV9yYW5nZShzdGFydF92bSwgZW5kX3ZtLCAwKTsNCiB9DQo=
---1463811839-328070892-1070326447=:16352--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
