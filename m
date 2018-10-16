Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZFW-0006fH-EZ
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 23:59:43 +0000
Message-ID: <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
Subject: Re: [RFC v1 12/31] checkpatch: added support for struct MOCK(foo)
 syntax
From: Joe Perches <joe@perches.com>
Date: Tue, 16 Oct 2018 16:59:26 -0700
In-Reply-To: <20181016235120.138227-13-brendanhiggins@google.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-13-brendanhiggins@google.com>
Mime-Version: 1.0
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
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, jdike@addtoit.com, kunit-dev@googlegroups.com

On Tue, 2018-10-16 at 16:51 -0700, Brendan Higgins wrote:
> This adds struct MOCK(foo) as a NonptrType so that it is recognized
> correctly in declarations.

I think this commit message is lacking context.


> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 447857ffaf6be..9806f190796de 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -745,6 +745,10 @@ sub build_types {
>  			(?:
>  				(?:typeof|__typeof__)\s*\([^\)]*\)|
>  				(?:$typeTypedefs\b)|
> +				# Matching a \b breaks struct MOCK(foo) syntax,
> +				# so we need to have it not lumped in with the
> +				# types in @typeList.
> +				(?:struct\s+MOCK\($Ident\))|
>  				(?:${all}\b)
>  			)
>  			(?:\s+$Modifier|\s+const)*


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

