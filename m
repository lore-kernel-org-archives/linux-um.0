Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
References: <20181016235120.138227-1-brendanhiggins@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42737f55-0d42-dffe-7b34-e24666e713a0@infradead.org>
Date: Wed, 17 Oct 2018 16:12:00 -0700
MIME-Version: 1.0
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Content-Language: en-US
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
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, jdike@addtoit.com, kunit-dev@googlegroups.com

On 10/16/18 4:50 PM, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.

Hi,

Just a general comment:

Documentation/process/submitting-patches.rst says:
<<Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.>>

That also means saying things like:
... test: add
instead of ... test: added
and "enable" instead of "enabled"
and "improve" instead of "improved"
and "implement" instead of "implemented".



thanks.
-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

