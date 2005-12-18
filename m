Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eo0kZ-000171-ER for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 07:47:03 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eo0kU-0006pe-Jx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 07:47:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200512161736.28011.blaisorblade@yahoo.it>
	<200512161917.51015.rob@landley.net>
In-Reply-To: <200512161917.51015.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181646.44431.blaisorblade@yahoo.it>
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
Date: Sun, 18 Dec 2005 16:46:44 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 17 December 2005 02:17, Rob Landley wrote:
> On Friday 16 December 2005 10:36, Blaisorblade wrote:
> > Ok, finally I've collected some time together and I merged the needed
> > patches.
> >
> > So, I'm pleased to release 2.6.14-bs3, and hope I have not done any mess!

> > So, enjoy it, and report any bugs!
>
> 2.6.15-rc4 and up work pretty well for me so far.  What does this have that
> isn't already in mainline?

Backports _are_ backports, i.e. hopefully (up to a certain, limited degree), 
more stable.

However, the last SKAS0 compilation patch (Stop the insanity) has not yet been 
merged in mainline.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
