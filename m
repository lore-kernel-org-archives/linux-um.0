Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eiwaa-0004q8-9A for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Dec 2005 08:19:48 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EiwaV-0002sW-26
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Dec 2005 08:19:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <b1df7a2c0512020134v777af71ev@mail.gmail.com>
	<200512030405.10210.blaisorblade@yahoo.it>
	<b1df7a2c0512030455x2f9e2bb5s@mail.gmail.com>
In-Reply-To: <b1df7a2c0512030455x2f9e2bb5s@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041718.02045.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] about virtual smp in uml
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
Date: Sun, 4 Dec 2005 17:17:58 +0100
To: zhuang zhuanghou <zhuanghou@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 03 December 2005 13:55, zhuang zhuanghou wrote:
> Many thanks for your replying!!!
>
> > You need to force UML to run into TT mode:
> >
> > $ ./linux mode=tt ncpus=2 ubd0=rootfs
>
> Yes, I have given the mode=tt option in the command line, but still cannot
> work :(

Which way? Anyhow, if you really want that (for testing, it's not useful 
currently for performance) you want to use some older kernels (or try the 
latest 2.4, i.e. 2.4.3x + 2.4.28-bs2 patchset).
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
