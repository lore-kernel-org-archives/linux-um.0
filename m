Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4nT5-0001X4-LS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:25:35 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4nT4-0005RH-4Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 14:25:34 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
Message-Id: <20040907142338.73b2d1c6.akpm@osdl.org>
In-Reply-To: <200409072004.03343.blaisorblade_spam@yahoo.it>
References: <20040906174447.238788D1E@zion.localdomain>
	<20040906142641.067fdeb6.akpm@osdl.org>
	<200409072004.03343.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Tue, 7 Sep 2004 14:23:38 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> On Monday 06 September 2004 23:26, Andrew Morton wrote:
>  > Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
>  > of your patches.  Please prepare an English-language summary.  See
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>  Ok, but how can I specify the filename you'll give to the patch?
> 
>  It would make management between my tree and yours easier for me, if possible.

hm.  By choosing a suitable Subject:, I guess.

Start the Subject with "uml:" and then avoid getting fancy in the rest of
the subject and things should work out OK.  Spaces and other funny
characters are replaced with "-" and underscores are retained.

I use the below piece of ad-hoc revoltium to canonicalise Subject:s into
filenames:

line=$(echo "$line" | tr 'A-Z' 'a-z')
line=$(echo "$line" | sed -e 's/^subject:[ 	]*//')
line=$(echo "$line" | sed -e 's/^fw:[ 	]*//')
line=$(echo "$line" | sed -e 's/^fwd:[ 	]*//')
line=$(echo "$line" | sed -e 's/^aw:[ 	]*//')
line=$(echo "$line" | sed -e 's/^re:[ 	]*//')

line=$(echo "$line" | sed -e 's/^patch//')
line=$(echo "$line" | sed -e "s/['\(\)\<\>\{\}\,\.\\]//g")
line=$(echo "$line" | sed -e "s/[\#\*\&\+\^\!\~\`\:\?\;]//g")
line=$(echo "$line" | sed -e "s/[\$]//g")
line=$(echo "$line" | sed -e 's/"//g')
line=$(echo "$line" | sed -e 's/^[-]*//g')
line=$(echo "$line" | sed -e 's/\[[^]]*\]//g')
line=$(echo "$line" | sed -e 's/[ 	]*\[patch\][	]*//')
line=$(echo "$line" | sed -e 's/\[//g')
line=$(echo "$line" | sed -e 's/\]//g')
line=$(echo "$line" | sed -e 's/^[ 	]*//')
line=$(echo "$line" | sed -e 's/ -/-/g')
line=$(echo "$line" | sed -e 's/- /-/g')
line=$(echo "$line" | sed -e 's/[ 	][ 	]*/-/g')
line=$(echo "$line" | sed -e 's,/,-,g')
line=$(echo "$line" | sed -e 's/--/-/g')
line=$(echo "$line" | sed -e 's/-$//g')
line=$(echo "$line" | sed -e 's/^-//g')



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
