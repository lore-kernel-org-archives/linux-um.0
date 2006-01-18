Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzAEr-0000iR-Om for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 02:08:25 -0800
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzAEr-0007aR-4s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 02:08:25 -0800
Message-ID: <43CE13AB.4000906@gentoo.org>
From: Daniel Drake <dsd@gentoo.org>
MIME-Version: 1.0
References: <43CA5642.9060205@gentoo.org>
	<200601160314.05831.blaisorblade@yahoo.it>
	<43CD4B1B.1060806@gentoo.org>
	<200601180020.26838.blaisorblade@yahoo.it>
In-Reply-To: <200601180020.26838.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: -bs patchset still useful for users?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Jan 2006 10:08:43 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Given I do use Gentoo, and I understand ebuilds, is that problem solvable 
> (i.e. by me becoming maintainer?)

Yes, and it would be great to see this happen!

> Don't know well what this implies (I looked at "How to become a Gentoo 
> developer" docs and it seemed require much more than what I do for -bs), but 
> could still be pursued.

The procedure may seem a bit much given that you will only be 
maintaining one package (at least initially), but you actually are given 
commit access to the whole tree (like all other developers). You need to 
read over the policies and show that you understand them.

You'll have to answer these questions:

http://www.gentoo.org/proj/en/devrel/quiz/ebuild-quiz.txt

All of the needed information can be found here:

http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml

If you need any help or have any questions then you are free to ask me. 
There is also a 2nd quiz later, with questions similar to the first.

As well as that, it usually takes 28 days to complete the process, so if 
you are happy with all of this, let me know and I'll get the ball 
rolling right away.

> There is an useful feature in -bs which isn't included in mainline (because 
> Jeff Dike legitimaly thinks it's not something which should be in kernel), 
> and which could be added to gentoo-sources, I hope.

gentoo-sources requires patches to be merged or at least headed upstream 
into Linus' tree, with very few exceptions. In general we wouldn't 
include this sort of patch.

However, if you are willing to become a developer and look after 
usermode-sources then this won't be an issue.

Thanks!
Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
