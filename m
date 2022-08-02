Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 2 Aug 2022 13:26:47 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 00/31] Rust support
Message-ID: <YukYByl76DKqa+iD@casper.infradead.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
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
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:49:47AM +0200, Miguel Ojeda wrote:
> Some of the improvements to the abstractions and example drivers are:
> 
>   - Filesystem support (`fs` module), including:
> 
>       + `INode` type (which wraps `struct inode`).
>       + `DEntry` type (which wraps `struct dentry`).
>       + `Filename` type (which wraps `struct filename`).
>       + `Registration` type.
>       + `Type` and `Context` traits.
>       + `SuperBlock` type (which wraps `struct super_block` and takes
>         advantage of typestates for its initialization).
>       + File system parameters support (with a `Value` enum; `Spec*`
>         and `Constant*` types, `define_fs_params!` macro...).
>       + File system flags.
>       + `module_fs!` macro to simplify registering kernel modules that
>         only implement a single file system.
>       + A file system sample.

None of this (afaict) has been discussed on linux-fsdevel.  And I may
have missed somethiing, but I don't see the fs module in this series
of patches.  Could linux-fsdevel be cc'd on the development of Rust
support for filesystems in the future?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

