Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDpRg-0003Hs-K2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 11:49:12 -0700
Received: from smtp2.poczta.onet.pl ([213.180.130.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDpRf-0002Nu-VQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 11:49:12 -0700
From: Marcin Pawlik <wapkil@op.pl>
Subject: Re: [uml-devel] [patch] Re: Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
Message-ID: <20040414170943.GA7894@mpmain>
References: <20040414133215.GA7464@mpmain>
	<Pine.LNX.4.44.0404141623190.2915-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404141623190.2915-100000@filer.marasystems.com>
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
Date: Wed, 14 Apr 2004 19:09:43 +0200
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 14 at 16:44, Henrik Nordstrom wrote:
> On Wed, 14 Apr 2004, Marcin Pawlik wrote:
> 
>> Do you know where and which thread closes the files? I tried to add
>> file closing to kill_io_thread() (patch attached) and it helps but I
>> think it should also be performed without my code.
> 
> No, I do not remember, but the thread which originally opened and
> locked the file is apparently not around after the UML has booted.

Yes, but this is not necessarily a problem. Any thread sharing file
description table can close (and therefore unlock) the file.

[...]
>>>  int os_lock_file(int fd, int excl)
>>>  {
>>> +#if USE_FCNTL_LOCK
>>>  	int type = excl ? F_WRLCK : F_RDLCK;
>>>  	struct flock lock = ((struct flock) { .l_type	= type,
>>>  					      .l_whence	= SEEK_SET,
>>> @@ -710,6 +711,21 @@
>>>  	err = save;
>>>   out:
>>>  	return(err);
>>> +#else
>>> +	int type = excl ? LOCK_EX : LOCK_SH;
>> 
>> I don't understand this. IMO excl should be F_RDLCK or F_WRLCK.
>> F_RDLCK is 0, F_WRLCK is 1 and LOCK_EX is 2 so you will always use
>> LOCK_SH.
> 
> ???
> 
> excl is a boolean, true if the lock should be exclusive (write

Ups. Yes, you are absolutely right. I thought... Well I don't know.
I'm sorry. Probably I should take some sleep :/

[...]
> Seems to works here.. there os no other uses of F_SETLK in my uml
> tree.  Using this successfully on RedHat-8 (2.4.20 somthing host
> kernel, no SKAS)  and Fedora Core 2 test 1 + SKAS (2.6.something +
> SKAS host kernel)..

I tried it on Debian testing/unstable with different host kernels
(2.4.25, 2.4.25 with skas, 2.6.5, 2.4.18-1-k7 from Debian) and the same
binary on RHEL 3.0 with some 2.4.21. Doesn't work for me. After "cad" or
"halt" in uml_mconsole I have sleeping and traced proceses left. 

I placed my testing UML binary and the filesystem (infinite loop in
/sbin/init) on http://www.pwr.wroc.pl/~marcinp/uml/uml.tar.gz (~1.2 MB).
Maybe it depends on UML configuration or compiler used. Could you send
me your --showconfig?

Regards,

-- 
Marcin Pawlik


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
