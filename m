Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E14Qi-0004FP-H1	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 08:48:16 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E14Qi-0004wl-4p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 08:48:16 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] NPTL pthread_create() cannot work.
References: <AD266326EC54D9118CE700110A9E2BE205EA47EA@zch07exm01.corp.mot.com>
In-Reply-To: <AD266326EC54D9118CE700110A9E2BE205EA47EA@zch07exm01.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051754.34058.blaisorblade@yahoo.it>
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
Date: Fri, 5 Aug 2005 17:54:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Zhu Tom-a2289c <A2289c@motorola.com>

On Friday 05 August 2005 09:34, Zhu Tom-a2289c wrote:
> 1.
> I still fail to use these patches on git3/4,

Hm, ok... there will be probably some trivial reject...I cannot update those 
patches right now since I haven't enough bandwidth.

Just to make sure: you got errors applying until TLS patches, right? Anyhow, 
to get the TLS changes only, you need to apply only the following 4 patches:

uml-clean-arch_switch
uml-tls-support-sc-tables
uml-add-tls-support
uml-add-tls-support-debug

They almost apply even on 2.6.12, so should apply for sure on 2.6.13-rc4.

And leave out uml-add-tls-support-flush-empty, it's still broken for now.

> so, I just made my local fix on 2.6.12-rc4.

> pthread_create works goods.
> and then find your fix patch include it, seems my fix
> is not wrong. :-)
Yes, I was probably missing some sleep. Only difference in my patches is that 
return value is set to set_tls_entry return value (and this matches with 
i386).

Does the system boots ok in that config, including sshd and apps like MySQL / 
Apache / Java ? With the previous version of the patches, no TLS data would 
work for sure... and sshd still doesn't work on my Sarge (which seems 
particularly picky - other people got success with other distros with much 
less changes).
> 2.
> in tls.c,
> there are some code looking up the tls_arry

> for (idx = GDT_ENTRY_TLS_MIN; idx < GDT_ENTRY_TLS_MAX; idx++) {
> shall we use "idx <= GDT_ENTRY_TLS_MAX"?
Good catch, thanks, even if this isn't going yet to be the *final* fix (since 
we aren't likely using the last slot).
> since
> #define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)

> Thanks,
> Tom
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
