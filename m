Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1Shjnv-0000YJ-1K for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 16:00:19 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Shjnp-0002Zz-0G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 16:00:18 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1Shjng-0006dr-CO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 18:00:04 +0200
Received: from 173-164-30-65-Nashville.hfc.comcastbusiness.net
	([173.164.30.65]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 18:00:04 +0200
Received: from wad by 173-164-30-65-Nashville.hfc.comcastbusiness.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 18:00:04 +0200
From: Will Drewry <wad@dataspill.org>
Date: Thu, 21 Jun 2012 15:56:26 +0000 (UTC)
Message-ID: <loom.20120621T174831-991@post.gmane.org>
References: <4F3C1B06.7080506@nagafix.co.uk>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] X11 vfb forward ported to 3.2
To: user-mode-linux-devel@lists.sourceforge.net

Antoine Martin <antoine <at> nagafix.co.uk> writes:

> 
> Whilst I was looking at all the docs and patches that I have for the
> wiki/uml website, I found the old x11-fb patch from Gerd Knorr's and
> forward ported it to 3.2
> Got as far as the point where it builds and shows a window when you
> start the kernel with:
> ./vmlinux x11=800x600
> As reported at the time of the original patch, all I get is a black
> window... I'll try to see if I can figure out why it's not updating.
> Here it is if you want to try it / comment / help:
> http://uml.devloop.org.uk/vfb-3.2.patch

I was just playing with this the other evening. I tweaked your/Gerd's patch in a 
few places (using it on 3.5.0-rc2), but the main non-porting related change 
seems to be in the nopage helper.  It uses pgoff as if it were the virtual 
address instead of as a direct offset for the VMA.  Fixing that got me a working 
fb.

I've only tested with the test program from here:
  http://cep.xor.aps.anl.gov/software/qt4-x11-4.2.2/qtopiacore-
testingframebuffer.html
which draws a gradient.

Here's the tiny tweak (which is not stylistically correct, etc):

@static int
@x11_fb_vm_nopage(struct vm_area_struct *vma, struct vm_fault *vmf)
@{
...
->-------int pgnr = (vmf->pgoff - vma->vm_start) >> PAGE_SHIFT;
+>-------unsigned long pgnr = vmf->pgoff;

Not sure if anyone still cares, but if I end up getting it more cleaned up, I'll 
post a 3.5 port in a weekend in the near future :)

cheers!
will


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

