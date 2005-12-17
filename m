Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EnQi2-0000zn-SL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Dec 2005 17:18:02 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EnQi1-00063a-FS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Dec 2005 17:18:02 -0800
From: Rob Landley <rob@landley.net>
References: <200512161736.28011.blaisorblade@yahoo.it>
In-Reply-To: <200512161736.28011.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161917.51015.rob@landley.net>
Subject: [uml-devel] Re: 2.6.14-bs3 released - fixes for SKAS0 modify_ldt()
	and stub compilation
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
Date: Fri, 16 Dec 2005 19:17:50 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 16 December 2005 10:36, Blaisorblade wrote:
> Ok, finally I've collected some time together and I merged the needed
> patches.
>
> So, I'm pleased to release 2.6.14-bs3, and hope I have not done any mess!
>
> Seriously, there's no new code in it, however the two SKAS0 things which I
> merged have given their share of problems in the past.
>
> The modify_ldt() patch (the one for Ubuntu TLS) wasn't merged before
> because it didn't compile well, and I didn't have the time to fix it
> properly.
>
> So, enjoy it, and report any bugs!

2.6.15-rc4 and up work pretty well for me so far.  What does this have that 
isn't already in mainline?

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
