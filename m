Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYTGd-0001WF-2X for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 13:36:43 -0700
Received: from fmmailgate01.web.de ([217.72.192.221])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYTGb-0000UT-EP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 13:36:43 -0700
Message-ID: <005601c77567$1ceddb60$eeeea8c0@aldipc>
From: "roland" <devzero@web.de>
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
	<46100EF5.7040802@nagafix.co.uk>
	<20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
Date: Mon, 2 Apr 2007 22:40:10 +0200
MIME-Version: 1.0
Subject: Re: [uml-devel] [RFC] UML kernel & rootfs bundle with every kernel
	release ?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

>> Why?  I've never understood what a framebuffer gives you that you
>> don't have now.
> Just like the network auto-configuration via dhcp, it would allow users to 
> download images+kernel and run them like appliances without understanding 
> anything about X or UML, just click and run.

mhh, i also think framebuffer would be nice, but the main idea behind my 
posting is have some recent linux kernel up and running without any effort - 
with main focus on kernel, not on apps.

sure, it would be nice to have X for the unexperienced users, but if you run 
uml and get networking up and running, you just do ssh -X into your uml and 
then you have your X. those people who run the latest kernel for testing 
special things are not unexperienced, but having a packaged kernel+rootfs 
"ready to run" would also make _their_ life easier.  think of testing 
several kernels in parallel to find/fix regressions.

booting into something graphical with kdm/gdm login, firefox inside etc 
would be really nice, but that would be probably overkill for the purpose it 
should serve. framebuffer and X could be added later to uml, and i`m sure, 
it will exist one day.

btw - i think besides that packaged uml+rootfs, the same thing could be 
distributed in other formats, i.e. qemu, vmware, M$ virtual pc (add your 
favourite v12n solution here)

regards
roland



----- Original Message ----- 
From: "Antoine Martin" <antoine@nagafix.co.uk>
To: "Jeff Dike" <jdike@addtoit.com>
Cc: "Blaisorblade" <blaisorblade@yahoo.it>; <devzero@web.de>; 
<user-mode-linux-devel@lists.sourceforge.net>; 
<linux-kernel@vger.kernel.org>
Sent: Monday, April 02, 2007 12:21 PM
Subject: Re: [uml-devel] [RFC] UML kernel & rootfs bundle with every kernel 
release ?


> Jeff Dike wrote:
>> On Sun, Apr 01, 2007 at 08:58:45PM +0100, Antoine Martin wrote:
>>> I reckon that one critical thing which could drastically increase the 
>>> user base would be to have a working virtual framebuffer implementation.
>>
>> Why?  I've never understood what a framebuffer gives you that you
>> don't have now.
> Just like the network auto-configuration via dhcp, it would allow users to 
> download images+kernel and run them like appliances without understanding 
> anything about X or UML, just click and run.
> We are all capable of setting up Xvfb here, but most users are not, which 
> is why they download ready-made images.
> It would also make it a lot easier to focus on writing a management UI, 
> hell if there isn't one shortly after, I'll do one myself!
> Think of a UML browser image (running IE via wine in a limited image with 
> just X + wine + IE - I would much prefer that to having wine+IE installed 
> locally), testing framebuffer apps like gtk-fb/cairo-fb without risking 
> your dev environment, etc...
>
> Antoine 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
