Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJH7B-00031b-2v for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 13:31:37 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FJH79-0008TR-Ht
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 13:31:36 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
In-Reply-To: <20060314202249.GB22286@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141631.46395.rob@landley.net>
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
Date: Tue, 14 Mar 2006 16:31:46 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Tuesday 14 March 2006 3:22 pm, Jeff Dike wrote:
> On Sat, Mar 11, 2006 at 01:01:41PM -0500, Rob Landley wrote:
> > On linux-2.6.16-rc5 I'm occasionally getting a hang starting up (with
> > rootfstype=hostfs), right after the initializing VFS line.
>
> I'm in the process of beating on the newer externfs-based hostfs and humfs,
> so I'm not too concerned with bugs in the old hostfs.  Having said that,
> if you can get a stack from the hang, it might turn out to be an easily
> diagnosed and fixed bug.

If it's in code that's going away I can live with it.  Let me know when the 
new hostfs is ready for wider testing and I'll give it a whirl...

Rob
-- 
Never bet against the cheap plastic solution.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
