Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eywsp-0004KH-2w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 11:52:47 -0800
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eywso-0008Dv-A9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 11:52:47 -0800
Message-ID: <43CD4B1B.1060806@gentoo.org>
From: Daniel Drake <dsd@gentoo.org>
MIME-Version: 1.0
References: <43CA5642.9060205@gentoo.org>
	<200601160314.05831.blaisorblade@yahoo.it>
In-Reply-To: <200601160314.05831.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 19:52:59 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Vanilla can do, however -bs has one little additional feature (mconsole-exec) 
> and contains all bug fixes written after the release (only few important ones 
> go to -stable, they're very restrictive and some -bs patches don't fix 
> critical "regressions"/crashes).
> 
> In fact, most times 2.6.n-bs is entirely merged in 2.6.(n+1).

Great.

Unless you have any strong objections, I will probably drop 
usermode-sources from Gentoo, and suggest that users migrate to 
gentoo-sources.

The problem is that usermode-sources doesn't have a maintainer within 
Gentoo. At the moment I've been taking care of it, but you know how 
clueless I am about UML. Also, it's a lot of work to maintain a kernel 
within a distro, and Gentoo have too many...

Thanks for helping us out with the UML bugs, and I hope you will 
continue spending a few minutes here and there providing input. I don't 
expect you will, but if you have time, you are always welcome to send 
important UML fixes to me for inclusion in Gentoo's patchset (we aren't 
quite as strict as -stable). I'll be keeping an eye on the -bs patchset 
anyway.

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
