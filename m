Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4oq1-003cHt-VC
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 19:19:31 +0000
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: UML: fix typo
In-Reply-To: <20220621072910.4704-1-1030steven@gmail.com>
References: <20220621072910.4704-1-1030steven@gmail.com>
Date: Fri, 24 Jun 2022 13:19:28 -0600
Message-ID: <87k09550ov.fsf@meer.lwn.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Steven Lung <1030steven@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Lung <1030steven@gmail.com>

Steven Lung <1030steven@gmail.com> writes:

> Replace 'absense' with 'absence'.
>
> Signed-off-by: Steven Lung <1030steven@gmail.com>
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 863f67b72..af2a97429 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -322,7 +322,7 @@ Shared Options
>  * ``v6=[0,1]`` to specify if a v6 connection is desired for all
>    transports which operate over IP. Additionally, for transports that
>    have some differences in the way they operate over v4 and v6 (for example
> -  EoL2TPv3), sets the correct mode of operation. In the absense of this
> +  EoL2TPv3), sets the correct mode of operation. In the absence of this
>    option, the socket type is determined based on what do the src and dst

Applied, thanks.  Congratulations on (I think) your first kernel patch.

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

