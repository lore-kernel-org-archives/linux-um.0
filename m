Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Paul Warren <pdw@ex-parrot.com>
Subject: Re: [uml-devel] Re: [uml-user] uml help __alloc_pages: 0-order
	allocation failed (gfp=0xf0/0)
Message-ID: <20050317195721.C18119@sphinx.mythic-beasts.com>
References: <000d01c52b22$8ab2c020$0201a8c0@lualele>
	<20050317190007.GA15341@taniwha.stupidest.org>
	<000501c52b25$717710e0$0201a8c0@lualele>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c52b25$717710e0$0201a8c0@lualele>;
	from itamar@ispbrasil.com.br on Thu, Mar 17, 2005 at 04:13:37PM
	-0300
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
Date: Thu, 17 Mar 2005 19:57:21 +0000
To: itamar <itamar@ispbrasil.com.br>
Cc: Chris Wedgwood <cw@f00f.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Thu, Mar 17, 2005 at 04:13:37PM -0300, itamar wrote:
> In the host I have 512 mb of ram
> 
> I am running the guest kernel with mem=256M
> 

Do you make significant use of hostfs filesystems?

Paul


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
