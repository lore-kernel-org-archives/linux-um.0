Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ets98-0000Pc-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 11:48:38 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ets93-0003Aq-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 11:48:38 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] grsecurity + skas UML patch for 2.6.14.5
References: <20060103135540.GN29312@platon.sk>
In-Reply-To: <20060103135540.GN29312@platon.sk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601032048.25302.blaisorblade@yahoo.it>
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
Date: Tue, 3 Jan 2006 20:48:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lubomir Host <rajo@platon.sk>

On Tuesday 03 January 2006 14:55, Lubomir Host wrote:
> Hi guys,
>
> I have one question. It is possible to run grsecurity kernel with skas3
> UML (User Mode Linux) patch from
>
> http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.14-
>v8.2/skas-2.6.14-v8.2.patch.bz2
>
> ? I have tried to create kernel with following patches (apply in this
> order on linux-2.6.14.3):
>
> http://www.grsecurity.net/grsecurity-2.1.7-2.6.14.3-200512111706.patch.gz
> http://www.kernel.org/pub/linux/kernel/v2.6/incr/patch-2.6.14.3-4.bz2
> http://www.kernel.org/pub/linux/kernel/v2.6/incr/patch-2.6.14.4-5.bz2
> http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/skas-2.6.14-
>v8.2/skas-2.6.14-v8.2.patch.bz2
>
> but little problem exists in linux-2.6.14.5-grsec-skas/mm/mmap.c.
> Problem is with function do_mmap_pgoff(), because this function is
> renamed in grsec and in skas patch too. I merge these patches together
> but I don't have enought experiences to check, if everything is OK.

> Please, can somebody check my patch? My patch can be downloaded from

> http://rajo.platon.sk/patches/linux-2.6/patch-2.6.14.5--grsecurity-2.1.7--s
>kas3-v8.2.patch http://rajo.platon.sk/patches/linux-2.6/

I don't have the time to check right now, but last time this question was 
brought up I found that a straightforward merge between patches (which had 
exactly the same problem) had a few (conceptual/theoretical) problems about 
security - I don't remember the details, but I didn't publish the result as I 
didn't find a satisfying solution.

"Satisfying" means "where all the restrictions imposed by normal GrSecurity 
continue to hold".
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
