Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ukoy-0005aL-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 20:30:08 -0700
Received: from snoopy.pacific.net.au ([61.8.0.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ukox-00042K-RG
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 20:30:08 -0700
From: Andrew Steele <fozzy@zip.com.au>
Subject: Re: [uml-devel] vmware vmmon and skas
Message-ID: <20030904032907.GD13455@zipworld.com.au>
References: <20030903130531.GB8159@zipworld.com.au> <200309040229.h842TiFs009493@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309040229.h842TiFs009493@ccure.karaya.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 4 Sep 2003 13:29:07 +1000
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Steele <fozzy@zip.com.au>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 03, 2003 at 10:29:44PM -0400 or thereabouts, Jeff Dike wrote:
> fozzy@zip.com.au said:
> > Based on what I saw in other files I simply added a new first argument
> > 	current->mm 
> 
> I haven't looked at the actual patch, but that's basically right.

Thanks Jeff.

Just out of curiosity, the places I looked where the ska patch changed
things, that first parameter was just mm.  Without puring over all the
ska patch, I presume there is a

	mm = current->mm

earlier on.  Was that just a simplification or are there some
occassions when mm is then changed so current->mm != mm?  And if so,
when does that happen and am I likely to be bitten by them?

Thanks
Andrew



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
