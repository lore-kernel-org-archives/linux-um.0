Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ep8Rm-0007fj-Ne for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Dec 2005 10:12:18 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ep8Rl-0002xn-TU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Dec 2005 10:12:18 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <Pine.LNX.4.63.0510161818210.10902@ligur.student.mh.se>
	<200512202123.34630.blaisorblade@yahoo.it>
	<Pine.LNX.4.64.0512202151210.11265@ligur.jwp.se>
In-Reply-To: <Pine.LNX.4.64.0512202151210.11265@ligur.jwp.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512211911.22870.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Bug in COW format - 64-bit incompatible with 32-bit
	due to struct padding (was: Re: [uml-user] uml_moo and large files)
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
Date: Wed, 21 Dec 2005 19:11:21 +0100
To: Joel Palmius <joel.palmius@miun.se>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 20 December 2005 22:13, Joel Palmius wrote:
> On Tue, 20 Dec 2005, Blaisorblade wrote:
> > So we need an utility doing just the setup and the writeout. Should be
> > easy to do, but I must learn the complete COW API. I will dismiss this
> > task if I see (as it seems) that there are no existing COW files.

> Personally I stopped trusting COW files once I saw I couldn't moo them, so
> I simply haven't used COWs. I guess most people trying COWs on an amd64
> system with 32bit umls would reach the same conclusion pretty fast.

I do exactly this, but I never use uml_moo (until the other day, when I saw 
this crash, remembered your report and successfully debugged it).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
