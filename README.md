SemVerSoC
=========

This is the source repository for <https://davemcewan.github.io/SemVerSoC/>.

If you would like to suggest changes, please open an
[issue](https://github.com/DaveMcEwan/SemVerSoC/issues) or, even better, a
[pull request](https://github.com/DaveMcEwan/SemVerSoC/pulls).
For example, one gap in the current draft is the need for a VHDL section to
compliment the SystemVerilog section.


Usage
-----

The fully static content of the GitHub Page is built using `SemVerSoC.md` as
the source and processed using `sed` and `pandoc`.
The most recently used versions are GNU sed 4.2.2 and pandoc 3.1.2.
To rebuild the HTML (`index.html`) and PDF (`SemVerSoC.pdf`) views, `cd` to a
clone of this repository then run `make`.


Licensing
---------

![https://creativecommons.org/licenses/by/4.0/](http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by.svg)

SemVerSoC is licensed under a
Creative Commons Attribution 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by/4.0/>.

