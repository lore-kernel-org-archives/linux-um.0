Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzbIK-0001Rf-IH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 07:01:48 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzbII-0005ks-3F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 07:01:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared"
	bogus error messages
References: <20060118235132.4626.74049.stgit@zion.home.lan>
	<20060118235522.4626.2825.stgit@zion.home.lan>
	<20060119042104.GC8265@ccure.user-mode-linux.org>
In-Reply-To: <20060119042104.GC8265@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191601.31805.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 16:01:28 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 19 January 2006 05:21, Jeff Dike wrote:
> On Thu, Jan 19, 2006 at 12:55:23AM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > -extern struct task_struct *idle_threads[NR_CPUS];
> > -
>
> BTW, this isn't the only problem there.  There are three declarations
> towards the bottom with struct task_struct in them which have to be moved.

I saw that after, but let's say a thing which I always forgot to say:

we're often using void * in protos when we can't include a type declaration in 
the needed file.

Gerd Knorr in his tty patch, instead, used forward declarations, like:

struct task_struct; 

what about that?

Those functions probably should be moved anyway because they're useless there, 
but I'm using this occasion to avoid forgetting this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
