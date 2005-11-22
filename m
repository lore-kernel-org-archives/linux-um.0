Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeeE7-0002ut-Vt for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 11:54:51 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EeeE3-0003hW-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 11:54:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Do we care about 4k stacks?
References: <200511210019.36848.rob@landley.net>
In-Reply-To: <200511210019.36848.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511222024.31218.blaisorblade@yahoo.it>
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
Date: Tue, 22 Nov 2005 20:24:30 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Monday 21 November 2005 07:19, Rob Landley wrote:
> Just curious if this is at all relevant to us, in light of the "yank 8k
> stacks" patch proposed...
>
> $ make checkstack
> objdump -d vmlinux $(find . -name '*.ko') | \
> perl /home/landley/linux-2.6.15-rc1/scripts/checkstack.pl i386

That's _SO_ much? Ouch... I now understand a lot more why Al Viro removed 
printf from UML usage (I tried to use printf rather than printk to report 
that a console channel is disabled; I later solved the problem with the 
kernel sprintf + a direct write() on stdout).

> 0xa010ddcf buffered_vfprintf:                           33168
> 0xa010deca buffered_vfprintf:                           33168
> 0xa00e5d5b buffered_vfprintf:                           8416
> 0xa00e5e43 buffered_vfprintf:                           8416
> 0xa0121ffb __res_vinit:                                 8256
> 0xa012293a __res_vinit:                                 8256
> 0xa011199c phys_pages_info:                             8212
> 0xa01117bf __get_nprocs:                                8208
> 0xa010a426 _IO_vfwprintf:                               4376
> 0xa00ebe33 _IO_wfile_seekoff:                           4280
> 0xa00ec0b9 _IO_wfile_seekoff:                           4280
> 0xa00f8626 __unix_grantpt:                              4252
> 0xa00f848f grantpt:                                     4188
> 0xa01103c6 execle:                                      4140

Ok, the two below functions are plain dumb - there's a MAXPATHLEN (i.e. 
PATH_MAX i.e. 4096) array on the stack, and they could happily be fixed.

All the rest seems plain glibc code and thus unfixable.

> 0xa0005119 make_uml_dir:                                4124
> 0xa00051bd make_uml_dir:                                4124
> 0xa0023dc0 make_tempfile:                               4124
> 0xa0023e5a make_tempfile:                               4124

> 0xa00e01d7 openpty:                                     4124
> 0xa011cd40 _dl_get_origin:                              4112
> 0xa011cdc4 _dl_get_origin:                              4112
>
> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
