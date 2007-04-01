Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HY6CX-0006vE-6a for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 12:58:57 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HY6CV-0005KJ-IW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 12:58:57 -0700
Message-ID: <46100EF5.7040802@nagafix.co.uk>
Date: Sun, 01 Apr 2007 20:58:45 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
In-Reply-To: <200704012108.14597.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: devzero@web.de, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

[...]
>> in short:
>> it`s quite some work to be done to have your uml 2.6.21 with root-fs up and
>> running and working cleanly. whenever i search the net for some appropriate
>> UML fs image, those i find are very often old and outdated...
> 
> Hmm... I'd think we need a wizard for configuration. Plus some distro-like 
> work for some specific issues - if I want to deploy a VM with hostname x, 
> network config y, and with Xnest running, I need an easier way to do that.
I think this can be solved by having the network auto-configure itself 
and make the startup scripts responsible for bringing up the interface 
and starting dhcp server on that interface. This is simple and does not 
require changes to the images. (it takes care of dns, ntp, smb, etc..)

> You can add settings on kernel command line and parse them inside UML - we 
> need standard packaged utilities for that (one of the rootfs builder 
> installed such stuff).
That would certainly complicate things quite a bit.

>> is there a project/website which is offering such ready to run "UML
>> kernel+rootfs release bundles" for download (i.e. new kernel,generic 
>> root-fs, modules inside, sources inside, compiler inside - in sync with the
>> latest stable vanilla) , or , would it make sense to establish such project
>> ? i.e. besides releasing the kernel, also releasing sort of a kernel
>> "runtime kit" and/or "devkit" ?
> 
> The runtime kit is there on nagafix.co.uk. The devkit is a main idea - most of 
> the work is to put something on the UML wiki and market well the idea - 
> creating such an image would be easy. But I haven't clear what you're talking 
> about - kernel development (why sources inside) or userspace development?
> 
> Also integrating all possible debug stuff would be useful, but I don't know 
> what's needed.
> 
>> i think this could be very helpful for linux-kernel, because it could be
>> tested by more people more quickly, more easily and thus, more often. just
>> download, do few steps for setup, start up that virtual machine and there
>> you go testing, hacking into the sources, do all that things you never
>> would do on your main system,  whatever....
>>
>> it would probably also add benefit to UML itself.
> 
> We need three things:
> a) more performance
> b) more users
> 
> c) more developers
> 
> a) leads to c), and b) too.
> 
>> does this sound dumb? i don`t know, so please comment.
> 
> No, it's not dumb. I'm even wanting to have a "Vmware-like" interface. Or at 
> least standard scripts for guest management.
I reckon that one critical thing which could drastically increase the 
user base would be to have a working virtual framebuffer implementation.
my 2p

Cheers
Antoine



> 
>> regards
>> roland
>>
>> PS:
>> ok, this would be some 500M to 1G download, but there`s lot`s of bandwidth
>> today - and P2P/Bittorrent.....
> 
> uml.nagafix.co.uk has some good kernels + images. With compression, they're 
> even as little as 50 Mb.
> 
> However, making UML easier to use, and marketing it for more application, is 
> very important. Various project do exist but they're not integrated, and they 
> do not try to (netkit is for network experimentation, but is also better as 
> VM management tool).
> 
> In short, we'd need somebody helping out really with the website (there is the 
> wiki but you must request an account via email, and it's not the main 
> website), with uml-utilities, and with new uml-utilities (you know 
> dm-snapshot is a faster COW? Something to setup it automatically would be 
> good).
> 
> There would be more to say on this, but I can't right now (I've other stuff to 
> do).
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
