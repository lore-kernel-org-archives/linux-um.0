Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIEKl-0006qw-VD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 15:44:31 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CIEKk-0008B6-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 15:44:31 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200410120305.24675.blaisorblade_spam@yahoo.it>
	<200410130040.i9D0eA3P004443@ccure.user-mode-linux.org>
In-Reply-To: <200410130040.i9D0eA3P004443@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410150044.47234.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [patch 0/17] UML updates,
	which must be merged before 2.6.9
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
Date: Fri, 15 Oct 2004 00:44:47 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 13 October 2004 02:40, Jeff Dike wrote:
> Thanks for pushing these.  I was about to, but you saved me the trouble.

Ok, thanks - however, I've just added (you'll see it in your mailbox) the "ln 
vmlinux linux" fix for the Single Linking Step, which I missed in the first 
merge. I have seen mention of it in your diary, which sadly I don't read 
frequently (I'll try to do this).

But it would be better to contact me directly (in this case, I just re-added 
again the archhelp, mentioning the deprecation of this target).

I also just built a vanilla -rc4-bk2 kernel and it worked like a charm. Andrew 
sent to Linux all the patches, and it appears all them were taken inside the 
BK snapshot.

This page is very nice:
http://linux.bkbits.net:8080/linux-2.5

As a side note: for now, to avoid breaking people scripts, ubd=sync and/or 
CONFIG_BLK_DEV_UBD_SYNC are still synonims (like people are used to threat 
them), and are also like replacing ubd0= with ubd0s= for all devices (like 
people used to think).

This way, the only think people will notice is more speed. Since you are 
always worried about people needing to change their boot scripts, this meets 
perfectly your criteria.

You had not agreed on this, but you can fix it later if you want - actually, 
you did not answer to my last email about this subject, in which I said what 
I say above (it happens frequently).

> BTW, I really like what you did with the build.  It is far better than it
> was before you started working on it.

About other work - could you drop the outdated SKAS patches from the official 
page? Updating two sites is slow, and waiting for you to pull the changes 
from CVS makes the CVS actually unusable (plus you must do the fucking 
"SF.net download dance", which I experienced too!).

A pointer to my archive directory would be fine, I guess.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
