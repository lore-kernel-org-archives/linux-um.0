Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Wwf-0003fl-DL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 08:43:33 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D6Wwa-0000Gh-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 08:43:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.10 command line longer than 512 characters
References: <Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no>
	<200503012137.j21LagMY009262@ccure.user-mode-linux.org>
	<Pine.LNX.4.62.0503012048120.6406@cube.iu.hio.no>
In-Reply-To: <Pine.LNX.4.62.0503012048120.6406@cube.iu.hio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021743.13026.blaisorblade@yahoo.it>
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
Date: Wed, 2 Mar 2005 17:43:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>

On Tuesday 01 March 2005 20:51, Kyrre M Begnum wrote:
> Thank you, i got a reply on that a while ago pointing me to a patch of
> that kind. I am gratefull for the follow-up though. If i may ask, is the
> patch on its way into 2.6.11? Blaisorblade mentioned it being on his list
> somewhere.
No, I was going to write a different patch...  Jeff's patch will fix the crash 
but leave 512 as the limit (Jeff confirmed it in the chat). I was going to 
extend the limit. We'll merge both patches for 2.6.12 (2.6.11 has just been 
released).

> >> I have noticed that when I supply a command line longer than 513
> >> characters (or was it 512?) the kernel crashes. Output supplied at the
> >> end of mail. This does not seem to be a problem on the old 2.4.24
> >> guest kernels. Is there a way I can change this, perhaps during kernel
> >> configuration?
> >
> > This is fixed in my long-command-line patch.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
